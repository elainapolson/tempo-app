Goals:

Scrape Billboard Top 100 or Spotify Charts data 
Create new song objects out of that data in our define_songs method
Use the Echonest API to scrape for each song's BPM
Assign each song a BPM from that data
Sort the songs into categories in our sort_into_category method

ECHONEST API
KEY: LIEBMXRVRAQ7FSQIX 

IF we do it with BILLBOARD:

Scrape from song title and artists from Billboard here: http://www.billboard.com/charts/hot-100
Then put artist and song title into the Echo Nest API Call below

Here's the Echo Nest API Call to find song info by artist
http://developer.echonest.com/api/v4/song/search?api_key=LIEBMXRVRAQ7FSQIX&artist=kanye%20west&title=all%20of%20the%20lights&bucket=audio_summary

Then we scrape that page for song tempo

IF we do it with SPOTIFY:

Scrape artist, titles, and track numbers from Spotify here: http://charts.spotify.com/api/tracks/most_streamed/us/weekly/latest
Then put track number into the Echo Nest API Call below

Here's the Echo Nest API Call to find song info by spotify track number
http://developer.echonest.com/api/v4/song/profile?api_key=LIEBMXRVRAQ7FSQIX&track_id=spotify:track:4toSP60xmDNCFuXly8ywNZ&bucket=id:spotify&bucket=audio_summary

Then we scrape that page for song tempo
Do we want to add danceability to party?