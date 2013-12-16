# OMDB RUBY CLIENT

Ruby client for parsing OMDB API for IMDB movies. You can review the OMDB API at [http://www.omdbapi.com/](http://www.omdbapi.com/)

### Sample Code

```ruby
link = Imdb::Link.new("http://www.imdb.com/title/tt1170358/")
data = Imdb::Parser.new(link).parse
```

Here is the data that returns from the API :

```ruby
#<Imdb::Movie:0x007f80b7da7390
 @actors=
   [#<Imdb::Actor:0x007f80b7dadf60
       @imdb_search_url="http://www.imdb.com/find?q=Martin%20Freeman&s=all",
       @name="Martin Freeman">,
         #<Imdb::Actor:0x007f80b7dadce0
           @imdb_search_url="http://www.imdb.com/find?q=%20Ian%20McKellen&s=all",
           @name=" Ian McKellen">,
         #<Imdb::Actor:0x007f80b7dad948
           @imdb_search_url="http://www.imdb.com/find?q=%20Richard%20Armitage&s=all",
           @name=" Richard Armitage">,
         #<Imdb::Actor:0x007f80b7dad5b0
           @imdb_search_url="http://www.imdb.com/find?q=%20Benedict%20Cumberbatch&s=all",
           @name=" Benedict Cumberbatch">],
       @director="Peter Jackson",
       @genre="Adventure, Drama, Fantasy",
       @id="tt1170358",
       @imdb_rating="N/A",
       @imdb_votes="N/A",
       @plot="After successfully crossing over (and under) the Misty Mountains, Thorin and Company must seek aid from a powerful stranger before taking on the dangers of Mirkwood Forest--without their Wizard. If they reach the human settlement of Lake-town it will be time for the hobbit Bilbo Baggins to fulfill his contract with the dwarves. The party must complete the journey to Lonely Mountain and burglar Baggins must seek out the Secret Door that will give them access to the hoard of the dragon Smaug. And, where has Gandalf got off to? And what is his secret business to the south?",
       @poster="http://ia.media-imdb.com/images/M/MV5BMzU0NDY0NDEzNV5BMl5BanBnXkFtZTgwOTIxNDU1MDE@._V1_SX300.jpg",
       @rated="PG-13",
       @released="13 Aralık 2013",
       @runtime="N/A",
       @title="The Hobbit: The Desolation of Smaug",
       @type="N/A",
       @url="http://www.imdb.com/title/tt1170358/",
       @writer="Fran Walsh, Philippa Boyens",
       @year="2013">
```
