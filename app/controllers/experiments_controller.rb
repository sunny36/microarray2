class ExperimentsController < ApplicationController
  
  def index
    @experiments = Experiment.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @experiments }
    end
  end

  def show
    @experiment = Experiment.find(params[:id])
  end

  def new
    @templates = Template.all
    @experiment = Experiment.new
  end

  def edit
    @experiment = Experiment.find(params[:id])
  end

  def create
    @experiment = Experiment.new(params[:experiment])
    @experiment.system_input_folder  = Rails.root.join("app", "assets", "images", "input").to_s
    @experiment.system_output_folder = Rails.root.join("app", "assets", "images", "output").to_s
    File.open(Rails.root.join("tmp", params[:experiment][:zip_file].original_filename),'wb') { |f| f.write params[:experiment][:zip_file].read }
    if @experiment.save
      unzip_file(Rails.root.join("tmp", params[:experiment][:zip_file].original_filename),
                 File.join(File.expand_path(ENV["MICROARRAY_ANALYZER_PATH"]), "input", "#{@experiment.id}"))
      system ""
      redirect_to @experiment, notice: 'Experiment was successfully created.'
    else
      render action: "new" 
    end
  end

  def update
    @experiment = Experiment.find(params[:id])
    respond_to do |format|
      if @experiment.update_attributes(params[:experiment])
        format.html { redirect_to @experiment, notice: 'Experiment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @experiment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @experiment = Experiment.find(params[:id])
    @experiment.destroy
    respond_to do |format|
      format.html { redirect_to experiments_url }
      format.json { head :no_content }
    end
  end

   def unzip_file(file, destination)
    Zip::ZipFile.open(file) { |zip_file|
      zip_file.each { |f|
        f_path=File.join(destination, f.name)
        FileUtils.mkdir_p(File.dirname(f_path))
        zip_file.extract(f, f_path) unless File.exist?(f_path)
      }
    }
  end
  
end
