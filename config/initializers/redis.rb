redis_uri = ENV.fetch("REDISTOGO_URL", "redis://localhost:6379")
REDIS = Redis.new(url: redis_uri)