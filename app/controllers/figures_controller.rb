class FiguresController < ApplicationController
  get '/figures' do
    erb :'/figures/index'
  end

  get '/figures/new' do
    erb :'figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  post '/figures' do
    puts params
    @figure = Figure.create(params[:figure])
    @figure.title_ids = params[:figure][:title_ids]
    @figure.landmark_ids = params[:figure][:landmark_ids]
    if !params[:title][:name].empty?
      title = Title.find_or_create_by(params[:title])
      @figure.titles << title
    end
    if !params[:landmark][:name].empty?
      landmark = Landmark.find_or_create_by(params[:landmark])
      @figure.landmarks << landmark
    end
    @figure.save

    redirect to "/figures/#{@figure.id}"
  end
end
