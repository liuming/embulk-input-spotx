require 'http'

module Embulk
  module Input

    class Spotx < InputPlugin
      Plugin.register_input("spotx", self)

      def self.transaction(config, &control)
        task = {
          "endpoint" => config.param("endpoint", :string),
          "client_id" => config.param("client_id", :string),
          "client_secret" => config.param("client_secret", :string),
          "refresh_token" => config.param("refresh_token", :string),
          "headers" => config.param("headers", :hash, default: {}),
        }

        columns = [
          Column.new(0, "record", :json),
        ]

        resume(task, columns, 1, &control)
      end

      def self.resume(task, columns, count, &control)
        _task_reports = yield(task, columns, count)

        next_config_diff = {}
        return next_config_diff
      end

      # TODO
      # def self.guess(config)
      #   sample_records = [
      #     {"example"=>"a", "column"=>1, "value"=>0.1},
      #     {"example"=>"a", "column"=>2, "value"=>0.2},
      #   ]
      #   columns = Guess::SchemaGuess.from_hash_records(sample_records)
      #   return {"columns" => columns}
      # end

      def init
        @endpoint = task["endpoint"]
        @client_id = task["client_id"]
        @client_secret = task["client_secret"]
        @refresh_token = task["refresh_token"]
        @headers = task["headers"]
      end

      def refresh_access_token
        uri = 'https://publisher-api.spotxchange.com/1.0/token'
        request_body = {
          client_id: @client_id,
          client_secret: @client_secret,
          refresh_token: @refresh_token,
          grant_type: 'refresh_token',
        }
        response = ::HTTP.post(uri, form: request_body)
        response_body = JSON.parse(response.body.to_s)
        response_body['value']['data']['access_token']
      end

      def request_data
        auth = {"Authorization" => "Bearer #{refresh_access_token}"}
        response = ::HTTP.get(@endpoint, headers: @headers.merge(auth))
        body = ''
        response.body.each do |chunk|
          chunk.gsub!('{"value":{"data":[', '')
          chunk.gsub!(']}}', '')
          chunk.gsub!('},{', "}\n{")
          body += chunk
        end
        return body
      end

      def run
        content = request_data
        content.split("\n").map do |line|
          row = JSON.parse(line)
          page_builder.add([row])
          row
        end
        page_builder.finish

        task_report = {}
        return task_report
      end
    end

  end
end
