<%-- 
    Document   : music-player
    Created on : May 12, 2023, 2:46:30 PM
    Author     : Sia_RTX3070
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Music-Player</title>
    </head>
    <body>
        <audio autoplay loop id="audio-player">
            <source src="${pageContext.request.contextPath}/shared/theme.mp3" type="audio/mpeg">
            Your browser does not support the audio tag.
        </audio>
        <button
            title="Suzume no Tojimari『Suzume』Theme Song, Credit to AniMelody - Anime Music"
            type="button"
            class="btn btn-info btn-floating btn-lg"
            id="btn-pause"
            >
            <i class="fas fa-pause"></i>
        </button>
        <button style="display: none;"
                title="Suzume no Tojimari『Suzume』Theme Song, Credit to AniMelody - Anime Music"
                type="button"
                class="btn btn-info btn-floating btn-lg"
                id="btn-play"
                >
            <i class="fas fa-play"></i>
        </button>
        <script type="text/javascript">
            const audioPlayer = document.getElementById("audio-player");
            const btnPlay = document.getElementById("btn-play");
            const btnPause = document.getElementById("btn-pause");

            //Audio Player's Volume
            audioPlayer.volume = 0.01;

            //Play Button
            btnPlay.addEventListener("click", () => {
                audioPlayer.play();
                btnPlay.style.display = "none";
                btnPause.style.display = "block";
            });

            //Pause Button
            btnPause.addEventListener("click", () => {
                audioPlayer.pause();
                btnPlay.style.display = "block";
                btnPause.style.display = "none";
            });
            
            //Check if user navigate away and save current stopped time.
            audioPlayer.addEventListener("timeupdate", () => {
               sessionStorage.setItem("audioTime", audioPlayer.currentTime); 
            });
            
            //Set where the music was left from previous page to continue on current page.
            const storedTime = sessionStorage.getItem("audioTime");
            if (storedTime) {
                audioPlayer.currentTime = storedTime;
            }
        </script>
    </body>
</html>
<style>
    #btn-play, #btn-pause {
        position: fixed;
        bottom: 90px;
        right: 20px;
        border-radius: 50%;
        z-index: 2;
    }
</style>

