redis_uri = ENV.fetch("REDISTOGO_URL", "redis://localhost:6379")
redis_client = Redis.new(url: redis_uri)
REDIS = Redis::Namespace.new("inp_reader", redis: redis_client)