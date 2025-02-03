from openai import OpenAI
client = OpenAI(api_key="your-api-key-here")

audio_file = open("C:/Users/makana/Downloads/WhatsApp Ptt 2024-12-13 at 13.22.44.ogg", "rb")
transcription = client.audio.transcriptions.create(
    model="whisper-1", 
    file=audio_file
)
print(transcription.text)
