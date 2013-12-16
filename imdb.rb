# encoding: utf-8

require 'net/http'
require 'json'
require 'uri'

module Imdb
  class Movie
    include ActiveModel::Serialization
    attr_accessor :title, :year, :rated, :released, :runtime, :genre, :director, :writer, :actors, :plot, :poster, :imdb_rating, :imdb_votes, :id, :url, :type

    def initialize(args)
      @title = args[:title]
      @year = args[:year]
      @rated = args[:rated]
      @released = localize_date(args[:released])
      @runtime = localize_runtime(args[:runtime])
      @genre = args[:genre]
      @director = args[:director]
      @writer = args[:writer]
      @actors = parse_actors(args[:actors])
      @plot = args[:plot]
      @poster = args[:poster]
      @imdb_rating = args[:imdb_rating]
      @imdb_votes = args[:imdb_votes]
      @id = args[:id]
      @url = args[:url]
      @type = args[:type]
    end

    def parse_actors(actors)
      result = []

      actors.split(",").each do |item|
        result << Actor.new(item)
      end

      result
    end

    def localize_runtime(input)
      input.gsub("h", "saat").gsub("min", "dakika")
    end

    def localize_date(input)
      months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
      localized_monts = ["Ocak", "Şubat", "Mart", "Nisan", "Mayıs", "Haziran", "Temmuz", "Ağustos", "Eylül", "Ekim", "Kasım", "Aralık"]

      months.each_with_index do |item, index|
        input = input.gsub(item, localized_monts[index])
      end

      input
    end
  end

  class Actor
    include ActiveModel::Serialization
    attr_accessor :name, :imdb_search_url

    def initialize(name)
      @name = name
      @imdb_search_url = "http://www.imdb.com/find?q=#{URI.escape(name)}&s=all"
    end
  end

  class Link
    include ActiveModel::Serialization
    attr_accessor :id, :original_url

    def initialize(url)
      raise SyntaxError, "Given parameter is not a valid IMDB url" unless self.class.is_imdb?(url)

      @original_url = url
      @id = parse
    end

    def parse
      regex = /^(https?:\/\/(www.)?imdb.com\/title\/)(.{9})(\/?)/i
      @original_url.scan(regex)[0][2]
    end

    # checks if the link is an IMDB movie url
    # returns flase if it's an actor/actress
    # ^https?:\/\/(www.)?imdb.com\/title\/.{9}\/?
    def self.is_imdb?(url)
      !(url =~ /^https?:\/\/(www.)?imdb.com\/title\/.{9}\/?/i).nil?
    end
  end

  class Parser
    attr_accessor :request_url, :original_url

    def initialize(imdb_link)
      @request_url = URI.escape("http://www.omdbapi.com/?i=#{imdb_link.id}&plot=full")
      @original_url = imdb_link.original_url
    end

    def parse
      result = fetch

      args = {
        title: result["Title"],
        year: result["Year"],
        rated: result["Rated"],
        released: result["Released"],
        runtime: result["Runtime"],
        genre: result["Genre"],
        director: result["Director"],
        writer: result["Writer"],
        actors: result["Actors"],
        plot: result["Plot"],
        poster: result["Poster"],
        imdb_rating: result["imdbRating"],
        imdb_votes: result["imdbVotes"],
        id: result["imdbID"],
        type: result["Type"],
        url: @original_url
      }

      Movie.new(args)
    end

    private
    def fetch
      uri = URI.parse(@request_url)

      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)

      JSON.parse(response.body)
    end
  end
end
