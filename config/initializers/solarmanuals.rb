SUBSCRIPTION_FEE = 3000
SUBSCRIPTION_MANUAL_FEE = 250
FREE_MANUALS = 10
CASUAL_FEE = 500

SUBSCRIPTION_INTERVAL = 1.month

EWAY = Rails.env.development? ? ['87654321', 'test@eway.com.au', 'test123', true] : ['11292907', 'info@solarmanuals.com.au', 'Avq22888']