class Admin::MenuclientesController < ApplicationController
  before_action :authenticate_user!
  layout  'admin/layouts/application'

  def index

    @menus = Menucliente.where(:estado=>1)

  end
end
