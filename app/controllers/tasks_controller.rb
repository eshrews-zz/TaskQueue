class TasksController < ApplicationController
  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all

    @tasks2 = Task.active
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end

  # GET /
  def activeindex
    @tasks = Task.active
    
    respond_to do |format|
      format.html { render :activeindex }
      format.json { render json: @tasks }
    end
  end


  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = Task.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(params[:task])

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render json: @task, status: :created, location: @task }
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
      format.js
    end
  end

  def update
    Rails.logger.info("PARAMS: #{params.inspect}")
    @task = Task.find(params[:id])
    
    #This contruct could probably use some work
    #and alternatively i could have used another url
    #like /tasks/1/complete . Not sure if using post variables
    #is better  
    if params[:completed].to_i == 1
      @task.completed = true
      @task.save()
    end
    redirect_to :root 
  end



end
