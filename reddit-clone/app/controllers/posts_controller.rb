class PostsController < ApplicationController

    before_action :require_logged_in, only: [:new, :create, :edit, :update]

    def new
    end

    def create
    end

    def edit
    end

    def update
    end

    def show
    end
end
