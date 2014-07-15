class SearchesController < ApplicationController

  def search
  end

  def show
    respond_to do |f|
      if params[:q].empty?
        flash.now[:notice] = "You gotta give me something!"
        f.html { return render "search" }
      end

      query = params[:q].split.collect(&:downcase).join(" ")
      handle_query(params[:category], query, f)
    end
  end

  private

  def handle_query(category, query, f)
    results_from_db = check_database(category, query)
    if results_from_db.blank?
      results_from_rt = check_rt(category, query)
      if results_from_rt.blank?
        flash.now[:notice] = "I'm sorry, nothing matched what you were looking for."
        f.html { render "search" }
        f.json { render json: {}, status: 200 }
      else
        return save_and_display(results_from_rt, query, f)
      end
    end

    @results = results_from_db
    f.json { render json: @results, include: [:actors, :genres, :directors], status: 200 }
    if @results.count == 1
      f.html { redirect_to send("#{category.downcase}_path", results_from_db.first) }
    else
      f.html { render "show" }
    end
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

  def save_and_display(rt_result, query, f)
    RTQuerier.save_to_db(rt_result)
    @results = Movie.where('lower(title) LIKE ?', "%#{query}%")
    if @results.empty?
      flash.now[:notice] = "I'm sorry, nothing matched what you were looking for."
      f.html { render "search" }
      f.json { render json: {}, status: 200 }
    end
    f.html { redirect_to movie_path(@results.first) if @results.count == 1 }
    f.json { render json: @results, include: [:actors, :genres, :directors], status: 200 }
  end
end
