class EventsController < ApplicationController
  before_filter :find_event, :only => [ :show, :edit, :update, :destroy]
  def index
    #@events = Event.all
    @events = Event.page(params[:page]).per(5)
  end
  def new
    @event = Event.new 
  end
  def create
    @event = Event.new(params[:event])
    if @event.save
      flash[:notice] = "event was successfully created"
      redirect_to :action => :index
    else
      render :action => :new
    end	
  end
  def show 
    @page_title = @event.name
  end
  def edit
  end
  def update
     if @event.update_attributes(params[:event])
       flash[:notice] = "event was successfully updated"
        redirect_to :action => :show, :id => @event
     else
        render :action => :edit
  end  

  end
  def destroy
    flash[:alert] = "event was successfully deleted"
    @event.destroy
  
    redirect_to :action => :index
  end
  protected
  def find_event
    @event=Event.find(params[:id])
  end
end
