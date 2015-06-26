class Admin::PlanclientesController < ApplicationController

  before_action :authenticate_user!
  layout  'admin/layouts/application'

  def index
    @clientes = Customers.all
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
