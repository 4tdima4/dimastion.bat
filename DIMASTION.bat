@echo off
setlocal enabledelayedexpansion
chcp 65001 > nul

set "BIN=%~dp0bin\"
set "LISTS=%~dp0lists\"
set "TEMP_DIR=%temp%\zapret\"
if not exist "%TEMP_DIR%" mkdir "%TEMP_DIR%"

set "OPTIMIZED_LIST=%TEMP_DIR%optimized_list.txt"
if exist "%OPTIMIZED_LIST%" del "%OPTIMIZED_LIST%"

set "extract=0"
for /f "usebackq tokens=*" %%a in ("%~f0") do (
    if "%%a"==":LIST_END" set "extract=0"
    if !extract!==1 echo %%a>>"%OPTIMIZED_LIST%"
    if "%%a"==":LIST_START" set "extract=1"
)

set "DISCORD_TEMP=%TEMP_DIR%discord_temp.txt"
(
    echo discord.com
    echo discord.gg
    echo discord.media
    echo discordapp.com
    echo discordapp.net
    echo cdn.discordapp.com
    echo media.discordapp.net
) > "%DISCORD_TEMP%"
type "%DISCORD_TEMP%" >> "%OPTIMIZED_LIST%"

(
    echo youtube.com
    echo youtu.be
    echo googlevideo.com
    echo ytimg.com
) >> "%OPTIMIZED_LIST%"

sort "%OPTIMIZED_LIST%" /unique > "%OPTIMIZED_LIST%.sorted"
move /y "%OPTIMIZED_LIST%.sorted" "%OPTIMIZED_LIST%" >nul

cd /d "%~dp0"
if exist "service.bat" (
    call service.bat status_zapret
    call service.bat load_game_filter
    echo.
)

cd /d "%BIN%"

echo Запуск DIMASTION с оптимизированными настройками...
echo.

start "zapret: %~n0" /min "%BIN%winws.exe" ^
--wf-tcp=80,443,2053,2083,2087,2096,8443,%GameFilter% ^
--wf-udp=443,19294-19344,50000-50100,%GameFilter% ^
--filter-udp=443 ^
--hostlist="%OPTIMIZED_LIST%" ^
--hostlist-exclude="%LISTS%list-exclude.txt" ^
--dpi-desync=fake ^
--dpi-desync-repeats=9 ^
--dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" ^
--new ^
--filter-udp=19294-19344,50000-50100 ^
--filter-l7=discord,stun ^
--dpi-desync=fake ^
--dpi-desync-repeats=5 ^
--new ^
--filter-tcp=2053,2083,2087,2096,8443 ^
--hostlist-domains=discord.media ^
--dpi-desync=fake,split ^
--dpi-desync-split-pos=1 ^
--dpi-desync-fooling=ts ^
--dpi-desync-repeats=6 ^
--dpi-desync-fake-tls="%BIN%tls_clienthello_www_google_com.bin" ^
--new ^
--filter-tcp=443 ^
--hostlist="%LISTS%list-google.txt" ^
--ip-id=zero ^
--dpi-desync=fake,split ^
--dpi-desync-split-pos=1 ^
--dpi-desync-fooling=ts ^
--dpi-desync-repeats=7 ^
--dpi-desync-fake-tls="%BIN%tls_clienthello_www_google_com.bin" ^
--new ^
--filter-tcp=80,443 ^
--hostlist="%OPTIMIZED_LIST%" ^
--hostlist-exclude="%LISTS%list-exclude.txt" ^
--dpi-desync=fake,split ^
--dpi-desync-split-pos=1 ^
--dpi-desync-fooling=ts ^
--dpi-desync-repeats=6 ^
--dpi-desync-fake-tls="%BIN%tls_clienthello_max_ru.bin" ^
--new ^
--filter-udp=443 ^
--ipset="%LISTS%ipset-all.txt" ^
--hostlist-exclude="%LISTS%list-exclude.txt" ^
--dpi-desync=fake ^
--dpi-desync-repeats=9 ^
--dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" ^
--new ^
--filter-tcp=80,443,%GameFilter% ^
--ipset="%LISTS%ipset-all.txt" ^
--hostlist-exclude="%LISTS%list-exclude.txt" ^
--dpi-desync=fake,split ^
--dpi-desync-split-pos=1 ^
--dpi-desync-fooling=ts ^
--dpi-desync-repeats=6 ^
--dpi-desync-fake-tls="%BIN%tls_clienthello_max_ru.bin" ^
--new ^
--filter-udp=%GameFilter% ^
--ipset="%LISTS%ipset-all.txt" ^
--dpi-desync=fake ^
--dpi-desync-autottl=2 ^
--dpi-desync-repeats=8 ^
--dpi-desync-any-protocol=1 ^
--dpi-desync-fake-unknown-udp="%BIN%quic_initial_www_google_com.bin"

echo Запуск завершен успешно!
timeout /t 2 /nobreak > nul
exit

:LIST_START
cloudflare-ech.com
encryptedsni.com
cloudflareaccess.com
cloudflareapps.com
cloudflarebolt.com
cloudflareclient.com
cloudflareinsights.com
cloudflareok.com
cloudflarepartners.com
cloudflareportal.com
cloudflarepreview.com
cloudflareresolve.com
cloudflaressl.com
cloudflarestatus.com
cloudflarestorage.com
cloudflarestream.com
cloudflaretest.com
dis.gd
discord-attachments-uploads-prd.storage.googleapis.com
discord.app
discord.co
discord.com
discord.design
discord.dev
discord.gift
discord.gifts
discord.gg
discord.media
discord.new
discord.store
discord.status
discord-activities.com
discordactivities.com
discordapp.com
discordapp.net
discordcdn.com
discordmerch.com
discordpartygames.com
discordsays.com
discordsez.com
discordstatus.com
frankerfacez.com
ffzap.com
betterttv.net
7tv.app
7tv.io
localizeapi.com
yt3.ggpht.com
yt4.ggpht.com
yt3.googleusercontent.com
googlevideo.com
jnn-pa.googleapis.com
stable.dl2.discordapp.net
wide-youtube.l.google.com
youtube-nocookie.com
youtube-ui.l.google.com
youtube.com
youtubeembeddedplayer.googleapis.com
youtubekids.com
youtubei.googleapis.com
youtu.be
yt-video-upload.l.google.com
ytimg.com
ytimg.l.google.com
pusher.com
live-video.net
ttvnw.net
twitch.tv
mail.ru
citilink.ru
yandex.com
nvidia.com
donationalerts.com
vk.com
yandex.kz
mts.ru
multimc.org
ya.ru
dns-shop.ru
habr.com
3dnews.ru
sberbank.ru
ozon.ru
wildberries.ru
microsoft.com
msi.com
akamaitechnologies.com
2ip.ru
yandex.ru
boosty.to
web.whatsapp.com
whatsapp.com
whatsapp.net
mmg.whatsapp.net
fbcdn.net
facebook.com
messenger.com
static.whatsapp.net
g.whatsapp.net
dyn.web.whatsapp.com
viber.com
viber.net
ads.viber.com
images.viber.com
content.viber.com
secure.viber.com
cdn.viber.com
api.viber.com
dl.viber.com
google.com
ajax.googleapis.com
amazonaws.com
cloudfront.net
akamaihd.net
akamai.net
jsdelivr.net
fastly.net
cdnjs.cloudflare.com
unpkg.com
azureedge.net
1e100.net
steampowered.com
steamcommunity.com
steamstatic.com
epicgames.com
steam.com
unrealengine.com
ea.com
origin.com
ubisoft.com
rockstargames.com
blizzard.com
github.com
githubassets.com
githubusercontent.com
gitlab.com
visualstudio.com
openai.com
chatgpt.com
anthropic.com
claude.ai
canva.com
docker.com
instagram.com
cdninstagram.com
x.com
twitter.com
t.co
netflix.com
pinterest.com
behance.net
artstation.com
facepunch.com
garrysmods.org
steamworkshopdownloader.io
videocopilot.net
textures.com
polyhaven.com
gstatic.com
googleusercontent.com
googleapis.com
googletagmanager.com
pornhub.com
site.su
chat.deepseek.com
gemini.google.com
www.playground.ru
mail.google.com
www.gamergeeks.net
websim.ai
hitrayvpn.net
bennettready.org 
happ.bot
propusk247.ru
steroidsp24.com
englishstockingclub.com
enigmaxxx.com
fatxxx.com
fatzero.com
favoritesex.com
favouriteporno.com
feel-porn.com
feelasians.com
feelingnasty.com
feelingnaughty.com
feelmybody.com
feet4free.com
feethunter.com
feetishes.com
feetnlegs.com
feetporn.com
feexxx.com
felixadultmovies.com
fem-dom-pictures.com
fem-dom-sex.com
fem-domxxx.com
female-amateurs.com
female-desperation.com
female-domination-bizarre.com
female-ejaculation-mpeg.com
female-ejaculations.com
female-flashers.com
female-males.com
female-mania.com
female-masturbation-pics.com
female-personals.com
femaleamateur.com
femaleanal.com
femaleathletes.com
femalebodybuildersnude.com
femalebondage.com
femalecam.com
femalecelebrities.com
femalecock.com
femaledominationpics.com
femaleerotic.com
femalelovers.com
femaleorgasmworld.com
femaleplaces.com
females-shemales.com
femalestripclub.com
femalewithcock.com
femalewrestling.com
femcontrol.com
femdomclub.com
femdomcontent.com
porno.co.za
smut.co.za
summitclub.co.za
design.ru
professionalmuscle.com
nnm.ru
ostrie.ru
porobeton.com
musclemayhem.com
mult.ru
midi.ru
livejournal.ru
jefflew.com
globalstarsoftware.com
getbig.com
fitsprot.ru
fc-zenit.ru
dreamworks.com
destinysphere.ru
body-building.ru
adriver.ru
caricatura.ru
nm.ru
damochka.ru
afrodita.ru
flabber.ru
kolyan.net
fishki.net
rapidshare.de
meebo.com
antonio00.by.ru
combats.com
combats.ru
udaff.com
apeha.ru
dailymotion.com
hidemyass.com
ninjaproxy.com
anonymouse.org
anonymizer.ru
the-cloak.com
odnoklassniki.ru
vkontakte.ru
rutube.ru
trinixy.ru
smotri.com
motorwars.ru
flashtown.ru 
f-games.ru
twitch.tv
www.twitch.tv
m.twitch.tv
tv.twitch.tv
ttvnw.net
jtvnw.net
live-video.net
twitchcdn.net
video-weaver.twitch.tv
clips-media-assets2.twitch.tv
assets.twitch.tv
static-cdn.jtvnw.net
api.twitch.tv
gql.twitch.tv
passport.twitch.tv
id.twitch.tv
irc-ws.chat.twitch.tv
pubsub-edge.twitch.tv
ext-twitch.tv
twitchadvertising.tv
usher.ttvnw.net
akamaized.net
roblox.ru
roblox.kz
roblox.ua
roblox.jp
roblox.co.uk
roblox.de
rbxcdn.com
rbxinfra.net
api.roblox.com
presence.roblox.com
friends.roblox.com
chat.roblox.com
corp.roblox.com
setup.roblox.com
about.roblox.com
blog.roblox.com
en.help.roblox.com
guilded.gg
create.roblox.com
m.roblox.com
roblox.fandom.com
developer.roblox.com
luau-lang.org
web.roblox.com
www.roblox.com
roblox.com
minecraft.net
education.minecraft.net
classic.minecraft.net
feedback.minecraft.net
help.minecraft.net
bugs.mojang.com
piston-meta.mojang.com
libraries.minecraft.net
mojang.com
aka.ms
minecraft
marketplace.minecraft.net
minecraftshop.com
minecraft.live
server.nitrado.net
realms.gg
minecraft.fandom.com
minecraft.wiki
curseforge.com
modrinth.com
namemc.com
photoshop.adobe.com
creativecloud.adobe.com
community.adobe.com
helpx.adobe.com
learning.adobe.com
exchange.adobe.com
assets.adobe.com
fonts.adobe.com
stock.adobe.com
cc-api-data.adobe.io
ims-na1.adobelogin.com
swupmf.adobe.com
firefly.adobe.com
substance3d.adobe.com
torproject.org
check.torproject.org
metrics.torproject.org
support.torproject.org
blog.torproject.org
community.torproject.org
255.255.255.255
9.9.9.9
149.112.112.112
8.8.8.8
8.8.4.4
0.0.0.0
1.1.1.1
1.0.0.1
208.67.222.222
208.67.220.220

:LIST_END
