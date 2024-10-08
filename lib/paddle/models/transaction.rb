module Paddle
  class Transaction < Object
    class << self
      def list(**params)
        response = Client.get_request("transactions", params: params)
        Collection.from_response(response, type: Transaction)
      end

      def create(items:, **params)
        attrs = { items: items }
        response = Client.post_request("transactions", body: attrs.merge(params))
        Transaction.new(response.body["data"])
      end

      def retrieve(id:, extra: nil)
        params = extra ? { include: extra } : {}
        response = Client.get_request("transactions/#{id}", params: params)
        Transaction.new(response.body["data"])
      end

      def update(id:, **params)
        response = Client.patch_request("transactions/#{id}", body: params)
        Transaction.new(response.body["data"])
      end

      def invoice(id:, disposition: "attachment")
        response = Client.get_request("transactions/#{id}/invoice?disposition=#{disposition}")
        if response.success?
          response.body["data"]["url"]
        end
      end

      def preview(items:, **params)
        attrs = { items: items }
        response = Client.post_request("transactions/preview", body: attrs.merge(params))
        Transaction.new(response.body["data"])
      end
    end
  end
end
