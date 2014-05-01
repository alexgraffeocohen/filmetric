class SearchesController < ApplicationController

  def search
  end

  def show
    if params[:q].empty?
      flash.now[:notice] = "You gotta give me something!"
      return render "search"
    end

    query = params[:q].split.collect(&:downcase).join(" ")
    handle_query(params[:category], query)
  end

  private

  def handle_query(category, query)
    @results = check_database(category, query)
    if @results.blank?
      @results = check_rt(category, query)
      if @results.blank?
        flash.now[:notice] = "I'm sorry, nothing matched what you were looking for."
        return render "search"
      else
        return save_and_display(@results, query)
      end 
    end
    redirect_to send("#{category.downcase}_path", @results.first) if @results.count == 1
  end

  def check_database(category, query)
    if category == "Movie" 
      Movie.where('lower(title) LIKE ?', "%#{query}%")
    else
      category.constantize.where('lower(name) LIKE ?', "%#{query}%")
    end
  end

  def check_rt(category, query)
    case category
    when "Movie"
      RTQuerier.find_by_title(query)
    end
  end
  
  def save_and_display(rt_result, query)
    begin
      RTQuerier.save_to_db(rt_result)
      @results = Movie.where('lower(title) LIKE ?', "%#{query}%")
      redirect_to movie_path(@results.first) if @results.count == 1
    rescue
      flash.now[:notice] = "I'm sorry, nothing matched what you were looking for."
      render "search"
    end
  end
end
