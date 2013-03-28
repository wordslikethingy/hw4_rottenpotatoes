require 'spec_helper'

describe MoviesController do
  # describe 'searching TMDb' do
  #   before :each do
  #     @fake_results = [mock('movie1'), mock('movie2')]
  #   end
  #   it 'should call the model method that performs TMDb search' do
  #     Movie.should_receive(:find_in_tmdb).with('hardware').
  #       and_return(@fake_results)
  #     post :search_tmdb, {:search_terms => 'hardware'}
  #   end
  #   describe 'after valid search' do
  #     before :each do
  #       Movie.stub(:find_in_tmdb).and_return(@fake_results)
  #       post :search_tmdb, {:search_terms => 'hardware'}
  #     end
  #     it 'should select the Search Results template for rendering' do
  #       response.should render_template('search_tmdb')
  #     end
  #     it 'should make the TMDb search results available to that template' do
  #       assigns(:movies).should == @fake_results
  #     end
  #   end
  # end
  
  # describe MoviesController do
  #   describe 'searching TMDb' do
  #     it 'should call the model method that performs TMDb search'
  #     it 'should select the Search Results template for rendering'
  #     it 'should make the TMDb search results available to that template'
  #   end
  # end
  
      
      # {"utf8"=>"✓", 
      #   "_method"=>"put", 
      #   "authenticity_token"=>"Sr+Do3v7WY7y32jnRIgonpt/3wxTiQVIq7WwNd3lWa4=", 
      #   "movie"=>
      #      {"title"=>"Aladdin", 
      #      "rating"=>"G", 
      #      "release_date(1i)"=>"1992", "release_date(2i)"=>"11", "release_date(3i)"=>"25", 
      #      "director"=>"Somebody"}, 
      #   "commit"=>"Update Movie Info", 
      #   "action"=>"update",
      #   "controller"=>"movies",
      #   "id"=>"31"}
      #
      
      #{"movie"=>{"title"=>"Aladdin", "director"=>"Somebody"}, "id"=>"310", "controller"=>"movies", "action"=>"update"}
  
  # Scenario: add director to existing movie
  #   When I go to the edit page for "Alien"
  #   And  I fill in "Director" with "Ridley Scott"
  #   And  I press "Update Movie Info"
  #   Then the director of "Alien" should be "Ridley Scott"
  # 
  describe 'Should call the find method of the movie model' do
    before :each do
      @id = "310"
    end
    # it 'Should show a movie' do
    #   Movie.should_receive(:find).with(@id)
    #   get :show, {id => @id}
    # end
    it 'Should call the model method that loads an exisiting movie' do
      Movie.should_receive(:find).with(@id)
      # {"action"=>"edit", "controller"=>"movies", "id"=>"31"}
      get :edit, {:id => @id}
    end
  end
  
  describe 'Viewing a movie on the edit page' do
    before :each do
      @id = "310"
    end
    it 'Should call the find method of the movie model' do
      Movie.should_receive(:find).with(@id)
      get :edit, {:id => @id}
    end
  end
  
  describe 'Adding a director to an existing movie' do
    before :each do
      @id = "310"
      @new_director = "Ridley Scott"
      @fake_movie = Movie.new
      @fake_movie.title = "Alien"
      @fake_movie.id = @id
    end
    describe 'stuff' do
      before :each do
        Movie.stub(:find).and_return(@fake_movie)
      end
      it 'Should call the model method that updates the director' do
        @fake_movie.should_receive(:update_attributes!).with({"title"=>"Alien", "director"=>@new_director}).and_return(:true)
        put :update, {:id => @id, :movie => {:title => "Alien", :director => @new_director}}
      end
      it 'Should call a redirect to the home page' do
        @fake_movie.stub(:update_attributes!).and_return(:true)
        put :update, {:id => @id, :movie => {:title => "Alien", :director => @new_director}}
        response.should redirect_to movie_path(@fake_movie)
      end
    end
  end
  
  describe 'Adding a movie' do
    before :each do
      #@fields = {:title => "Alien", :director => "Ridley Scott", :release_date(1i)=>"1979", :release_date(2i)=>"5", :release_date(3i)=>"25", :rating => "R"}
      #@fields = {:title => "Alien", :director => "Ridley Scott", :release_date=>"1979-05-25", :rating => "R"}
      @fields = {"title"=>"Alien", "director" => "Ridley Scott", "rating"=>"R", "release_date(1i)"=>"1979", "release_date(2i)"=>"5", "release_date(3i)"=>"25"}
      @fake_movie = Movie.new
      @fake_movie.title = "Alien"
      @fake_movie.release_date = "1979-05-25"
      @fake_movie.rating = "R"
      @fake_movie.director = "Ridley Scott"
    end
    it 'Should confirm the create method is called' do
      Movie.should_receive(:create!).with(@fields).and_return(@fake_movie)
      post :create, {:movie => @fields}
    end
    it 'Should confirm a redirect to the page for the new movie' do
      Movie.stub(:create!).and_return(@fake_movie)
      post :create, {:movie => @fields}
      response.should redirect_to movies_path
    end
  end
  
  describe 'Remove a movie' do
    before :each do
      @id = "310"
      @fake_movie = Movie.new
      @fake_movie.id = @id
      @fake_movie.title = "Alien"
      @fake_movie.release_date = "1979-05-25"
      @fake_movie.rating = "R"
      @fake_movie.director = "Ridley Scott"
    end
    it 'Should load the movie' do
      Movie.should_receive(:find).with(@id).and_return(@fake_movie)
      delete :destroy, {:id => @id}
    end
    
    # it 'Should call the destroy method on the movie' do
    #   Movie.stub(:find).and_return(@fake_movie)
    #   #@fake_movie.should_receive(:update_attributes!).with({"title"=>"Alien", "director"=>@new_director}).and_return(:true)
    #   @fake_movie.should_receive(:destroy)
    # end
    # it 'Should redirect to the movies page'
  end
  
  # Scenario: find movie with same director
  #   Given I am on the details page for "Star Wars"
  #   When  I follow "Find Movies With Same Director"
  #   Then  I should be on the Similar Movies page for "Star Wars"
  #   And   I should see "THX-1138"
  #   But   I should not see "Blade Runner"
  # describe 'Finding movies by the same diretor' do
  #   it 'Should call the model method to load a movie by id'
  #   it 'Should call the model method to load a list of movies by director'
  #   it 'Should select the By Director template for rendering'
  #   it 'Should make the movie list available to that template'
  # end
  
  # Scenario: can't find similar movies if we don't know director (sad path)
  #   Given I am on the details page for "Alien"
  #   Then  I should not see "Ridley Scott"
  #   When  I follow "Find Movies With Same Director"
  #   Then  I should be on the home page
  #   And   I should see "'Alien' has no director info"
  # describe 'Finding movies by the same diretor when there is no director' do
  #   it 'Should call the model method to load a movie by id'
  #   it 'Should see that the director is empty'
  #   it 'Should redirect to the home page'
  # end
end