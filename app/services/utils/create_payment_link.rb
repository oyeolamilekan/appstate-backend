module Utils
  class CreatePaymentLink < ApplicationService
    attr_reader :price_cents, :api_key, :product_name, :product_id, :store_slug

    def initialize(price_cents:, api_key:, product_name:, product_id:, store_slug:)
      @price_cents = price_cents
      @api_key = api_key
      @product_name = product_name
      @product_id = product_id
      @store_slug = store_slug
    end

    def call
      Stripe.api_key = api_key

      begin
        base_frontend_url = ENV.fetch('BASE_FRONTEND_URL', 'https://website.com')
        complete_url = Utils::SharedFunctions.add_subdomain(base_frontend_url, store_slug)
        session = Stripe::Checkout::Session.create({
          payment_method_types: ['card'],
          line_items: [{
            price_data: {
              currency: 'usd',
              product_data: { name: product_name },
              unit_amount: price_cents, # Amount in cents
            },
            quantity: 1, # Single item purchase
          }],
          mode: 'payment',
          success_url: complete_url + 'success?session_id={CHECKOUT_SESSION_ID}',
          cancel_url: complete_url + 'cancel',
          custom_fields: [
            {
              key: 'githubusername',
              label: { type: 'custom', custom: 'Github Username' },
              type: 'text',
            }
          ],
          metadata: {
            product_id: product_id
          }
        })
        [:success, session.url]
      rescue Stripe::StripeError => e
        Rails.logger.error("Stripe::StripeError payment failed: #{e.message}")
        [:error, "Error in creating payment link"]
      rescue => e
        Rails.logger.error("Stripe Error payment failed: #{e.message}")
        [:error, "Error in creating payment link"]
      ensure
        Stripe.api_key = nil  # Reset the API key after use
      end
    end
  end
end
