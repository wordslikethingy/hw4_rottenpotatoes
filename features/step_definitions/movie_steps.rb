Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    #debugger
    # example: {"title"=>"The Terminator", "rating"=>"R", "release_date"=>"26-Oct-1984"}
    Movie.create!(movie)
  end
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |arg1, arg2|
  movie = Movie.find_by_title(arg1)
  assert movie.director == arg2
  #pending # express the regexp above with the code you wish you had
end


Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  # grab the first table cell of all table rows since it contains the title
  movie_titles = page.all(:xpath, "//table//tr//td[1]")
  # make sure e1 appears before e2
  found_first = false
  movie_titles.each do |movie|
    if movie.text == e1
       found_first = true
    elsif movie.text == e2
      if found_first
        break
      else
        flunk "Second movie appeared before the first"
      end
    end
  end
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(', ').each do |da_rating|
    #debugger
    if uncheck == nil
      check("ratings_"+da_rating)
    else
      uncheck("ratings_"+da_rating)
    end
  end
end

Then /I should (not )?see movies with these ratings: (.*)/ do |not_included, rating_list|
  ratings = []
  rating_list.split(', ').each do |da_rating|
    ratings << da_rating
  end
  movies = Movie.find_all_by_rating(ratings)
  movies.each do |movie|
    if not_included == nil
      assert(page.has_content?(movie.title), "The Movie " + movie.title + " is missing from the list")
    else
      assert(page.has_content?(movie.title) == false, "The Movie " + movie.title + " is in the list when it should not be")
    end
  end
end

Then /I should see all the movies/ do
  assert(page.has_css?("table tr", :count => 11), "The table count does not match.  There should be 11 tr elements.")
end