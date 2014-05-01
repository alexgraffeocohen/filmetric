class SearchesController < ApplicationController

  def search
  end

  def show
    if params[:q].empty?
      flash.now[:notice] = "You gotta give me something!"
      return render "search"
    end

    query = params[:q].split.collect(&:downcase).join(" ")
    check_for_query_category(params[:category], query)
    
    if @results.empty?
      rt_result = check_rt(params[:category], query)
      if rt_result.empty?
        flash.now[:notice] = "I'm sorry, nothing matched what you were looking for."
        return render "search"
      else
        save_and_return(rt_result, query)
      end 
    end
  end

  private

  def check_for_query_category(category, query)
    if category == "Movie" 
      @results = Movie.where('lower(title) LIKE ?', "%#{query}%")
    else
      @results = category.constantize.where('lower(name) LIKE ?', "%#{query}%")
    end
    redirect_to send("#{category.downcase}_path", @results.first) if @results.count == 1
  end
  
  def check_rt(category, query)
    case category
    when "Movie"
      RTQuerier.find_by_title(query)
    end
  end
  
  def save_and_return(rt_result, query)
    begin
      RTQuerier.save_to_db(rt_result)
      @results = Movie.where('lower(title) LIKE ?', "%#{query}%")
      return redirect_to movie_path(@results.first) if @results.count == 1
    rescue
      flash.now[:notice] = "I'm sorry, nothing matched what you were looking for."
      return render "search"
    end
  end
end
