class TasksController < ApplicationController
  def index
    @tasks = Task.order(:completed, :title)
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.save
    redirect_to tasks_path
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if params[:task].present?
      # Execute when the form from the edit view is submitted
      if @task.update(task_params)
        redirect_to tasks_path, notice: 'Task was successfully updated.'
      else
        render :edit
      end
    else
      # Execute when the form from the index view is submitted
      if @task.update(completed: params[:completed] == 'true')
        redirect_to tasks_path, notice: 'Task was successfully updated.'
      else
        redirect_to tasks_path, alert: 'Task could not be updated.'
      end
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:title, :details, :completed)
  end
end
