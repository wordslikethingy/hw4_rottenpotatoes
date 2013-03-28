require 'spec_helper'

describe MoviesController do
  describe 'Should call the find method of the movie model' do
    before :each do
      @id = "310"
    end
    it 'Should call the model method that loads an exisiting movie' do
      Movie.should_receive(:find).with(@id)
      get :edit, {:id => @id}
    end
  end
  
  describe 'Viewing a movie on the edit page' do
    before :each do
      @id = "310"
    end
    it 'Should call the find method of the movie model' do
      Movie.should_receive(:find).with(@id)
      get :show, {:id => @id}
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
    
    it 'Should call the destroy method on the movie' do
      Movie.stub(:find).and_return(@fake_movie)
      @fake_movie.should_receive(:destroy)
      delete :destroy, {:id => @id}
    end
    it 'Should redirect to the movies page'
  end
  
  describe 'Viewing all movies by a director' do
    before :each do
      @id = "310"
      @fake_movie = Movie.new
      @fake_movie.id = @id
      @fake_movie.title = "Alien"
      @fake_movie.release_date = "1979-05-25"
      @fake_movie.rating = "R"
      @fake_movie.director = "Ridley Scott"
    end
    it 'Should call the find method of the Movie model' do
      Movie.should_receive(:find).with(@id).and_return(@fake_movie)
      get :by_director, {:id => @id}
    end
    it 'Should call the find_all_by_director method of the movie model if there is a director' do
      Movie.stub(:find).and_return(@fake_movie)
      get :by_director, {:id => @id}
    end
    it 'Should redirect to the home page if the loaded movie has no director' do
      @fake_movie.director = ''
      Movie.stub(:find).and_return(@fake_movie)
      Movie.should_receive(:find_all_by_director).with(@fake_movie.director)
      get :by_director, {:id => @id}
    end
  end
  
  describe 'Viewing all movies' do
    it 'Should show all movies when visited for the first time with no parameters' do
      get :index, {}
    end
    it 'Should show only movies with G and PG when they are selected' do
      get :index, {:ratings => {"G"=>"1", "PG"=>"1"}}
    end
    it 'Should show all movies sorted by release date when that field is selected' do
      get :index, {:sort => "release_date"}
    end
    it 'Should show all movies sorted by movie title when that field is selected' do
      get :index, {:sort => "title"}
    end
  end
end