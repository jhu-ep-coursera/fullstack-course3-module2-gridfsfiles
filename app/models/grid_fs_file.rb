class GridFsFile
  include ActiveModel::Model
  attr_accessor :contentType, :filename, :author, :topic
  attr_writer :contents
  attr_reader :id, :uploadDate, :chunkSize, :length, :md5

  def initialize(params={})
    Rails.logger.debug {"instantiating GridFsFile #{params}"}
    if params[:_id]  #hash came from GridFS
      @id=params[:_id].to_s
      @author=params[:metadata].nil? ? nil : params[:metadata][:author]
      @topic=params[:metadata].nil? ? nil : params[:metadata][:topic]
    else              #assume hash came from Rails
      @id=params[:id]
      @author=params[:author]
      @topic=params[:topic]
    end
    @chunkSize=params[:chunkSize]
    @uploadDate=params[:uploadDate]
    @contentType=params[:contentType]
    @filename=params[:filename]
    @length=params[:length]
    @md5=params[:md5]
    @contents=params[:contents]
    Rails.logger.debug {"instantiated GridFsFile #{self}"}
  end

  def persisted?
    !@id.nil?
  end
  def created_at
    nil
  end
  def updated_at
    nil
  end
  
  def self.mongo_client
    @@db ||= Mongoid::Clients.default
  end

  def self.id_criteria id
    {_id:BSON::ObjectId.from_string(id)}
  end
  def id_criteria
    self.class.id_criteria @id
  end

  def self.all
    files=[]
    mongo_client.database.fs.find.each do |r| 
      files << GridFsFile.new(r)
    end
    return files
  end

  def self.find id
    f=mongo_client.database.fs.find(id_criteria(id)).first
    return f.nil? ? nil : GridFsFile.new(f)
  end

  def contents
    Rails.logger.debug {"getting gridfs content #{@id}"}
    f=self.class.mongo_client.database.fs.find_one(id_criteria)
    if f 
      buffer = ""
      f.chunks.reduce([]) do |x,chunk| 
          buffer << chunk.data.data 
      end
      return buffer
    end 
  end
  
  def save
    Rails.logger.debug {"saving gridfs file #{self.to_s}"}
    description = {}
    description[:filename]=@filename          if !@filename.nil?
    description[:content_type]=@contentType   if !@contentType.nil?
    if @author || @topic
      description[:metadata] = {}
      description[:metadata][:author]=@author  if !@author.nil?
      description[:metadata][:topic]=@topic    if !@topic.nil?
    end

    if @contents
      Rails.logger.debug {"contents= #{@contents}"}
      grid_file = Mongo::Grid::File.new(@contents.read, description )
      id=self.class.mongo_client.database.fs.insert_one(grid_file)
      @id=id.to_s
      Rails.logger.debug {"saved gridfs file #{id}"}
      @id
    end
  end

  def update params
    #TODO
  end

  def destroy
    Rails.logger.debug {"destroying gridfs file #{@id}"}
    self.class.mongo_client.database.fs.find(id_criteria).delete_one
  end
end
