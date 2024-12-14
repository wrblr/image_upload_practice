class UploadedImagesController < ApplicationController
  require 'rtesseract'
  
  def create
    @uploaded_image = UploadedImage.new(uploaded_image_params)
  
    if @uploaded_image.save
      # Extract text from the image
      image_path = @uploaded_image.image.url
      extracted_text = RTesseract.new(image_path).to_s
  
      # Send the extracted text to ChatGPT
      client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))
      api_response = client.chat(
        parameters: {
          model: "gpt-4o",
          messages: [{ role: "user", content: extracted_text }]
        }
      )
  
      @response = api_response.fetch("choices").at(0).fetch("message").fetch("content")
  
      # Display the response
      redirect_to uploaded_image_path(@uploaded_image), notice: @response
    else
      render :new
    end
  end
  
  private
  
  def uploaded_image_params
    params.require(:uploaded_image).permit(:image)
  end
end
