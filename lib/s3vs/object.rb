require "json"
require "aws-sdk"

module S3VS
  class Object
    attr_reader(
      :bucket,
      :key,
      :s3_options,
    )

    def initialize(
      value:      nil,
      bucket:     ENV["S3VS_BUCKET"],
      key:        ENV["S3VS_KEY"] || "",
      auto_sync:  true,
      s3_options: {}
    )
      @bucket     = bucket
      @key        = key
      @auto_sync  = auto_sync
      @s3_options = s3_options
      @value      = value
      @value_hash = value.hash
    end

    def get
      load if @auto_sync

      @value
    end

    def set(object)
      if @value == object
        self
      else
        @value      = object
        @value_hash = object.hash

        save if @auto_sync
        self
      end
    end

    def load(options = {})
      get_object_options = options
      get_object_output  = s3_object.get(get_object_options)

      @loaded_at  = Time.now
      @etag       = get_object_output.etag
      @value      = JSON.load(get_object_output.body)
      @value_hash = @value.hash

      self
    end

    def save(options = {})
      put_object_options = {
        body:         @value.to_json,
        content_type: "application/json",
      }.merge(options)

      put_object_output = s3_object.put(put_object_options)

      @saved_at = Time.now
      @etag     = put_object_output.etag

      self
    end

    def delete!
      s3_object.delete
    end

    def to_s
      %(#<#{self.class} s3_object=s3://#{@bucket}/#{@key} value=#{@value}>)
    end

    def changed?
      @value_hash == @value.hash
    end

    def eql?(other)
      return false unless @bucket.eql?(other.bucket)
      return false unless @key.eql?(other.key)
      return false unless get.eql?(other.get)

      true
    end

    alias_method :==, :eql?

    private

    def s3
      @s3 ||= Aws::S3::Resource.new @s3_options
    end

    def s3_object
      s3.bucket(@bucket).object @key
    end
  end
end
