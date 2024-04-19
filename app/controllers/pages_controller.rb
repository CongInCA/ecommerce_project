class PagesController < ApplicationController
  def contact
    @contact_page = Page.find_by(title: "Contact")
  end

  def about
    @about_page = Page.find_by(title: "About")
  end
end
