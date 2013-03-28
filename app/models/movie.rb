class Movie < ActiveRecord::Base
  # before_validation :foo1
  # after_validation :foo2
  # before_save :foo3
  # after_save :foo4
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  # def foo1()
  #   x=1
  #   debugger
  #   x=2
  # end
  # def foo2()
  #   x=3
  #   debugger
  #   x=4
  # end
  # def foo3()
  #   x=5
  #   debugger
  #   x=6
  # end
  # def foo4()
  #   x=7
  #   debugger
  #   x=8
  # end
end
