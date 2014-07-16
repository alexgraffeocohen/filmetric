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

    @results = specify_query(results_from_db)
    f.json { render json: @results, include: [:actors, :genres, :directors], status: 200 }
    if @results.count == 1
      f.html { redirect_to send("#{category.downcase}_path", results_from_db.first) }
    else
      f.html { render "show" }
    end
  end

  def specify_query(results)
    if params[:actor]
      execute_specified_query(results, 'actor')
    elsif params[:director]
      execute_specified_query(results, 'director')
    else
      results
    end
  end

  def execute_specified_query(results, category)
    category_class = category.capitalize.constantize
    results.includes(category.pluralize.to_sym).map { |result|
      name = params[category.to_sym]
      table = category_class.arel_table
      result if result.send(category.pluralize).include?(category_class.where(table[:name].matches("%#{name}%")).first)
    }.compact
  end

  def check_database(category, query)
    if category == "Movie"
      Movie.where('lower(title) LIKE ?', "%#{query}%")
    else
      category_table = category.constantize.arel_table
      category.constantize.where(category_table[:name].matches("%#{query}%"))
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
