# This is a file to store all the global variables needed
# It's initiated only once when the mainWindow is created
# Please don't tamper with it

import os
import sys
import platform
import ctypes.wintypes
import Scripts.Configs as CFG
from Scripts.BasicLogger import Log

#//////////////////////////////////////////#
#//#    Global Variables Declarations   #//#
#//////////////////////////////////////////#

configData: dict[str, dict[str, str]]
modPath: str # /p2mm
modFilesPath: str # /p2mm/ModFiles
configPath: str
iow: bool = False # Windows system
iol: bool = False # Linux system
iosd: bool = False # Steam Deck/Steam OS 3.0 system
HadToResetConfig: bool = False
executable: str = os.path.abspath(sys.executable)
translations: dict[str, str]
AfterFunction: None

def init() -> None:
    global modPath, modFilesPath, configPath, iow, iol, iosd, linuxSessionType, translations

    if (sys.platform == "win32"):
        iow = True

        # Again thanks stackOverflow for this
        # This code allows us to get the document's folder on any windows pc with any language
        CSIDL_PERSONAL = 5       # My Documents
        SHGFP_TYPE_CURRENT = 0   # Get current, not default value

        buf = ctypes.create_unicode_buffer(ctypes.wintypes.MAX_PATH)
        ctypes.windll.shell32.SHGetFolderPathW(None, CSIDL_PERSONAL, None, SHGFP_TYPE_CURRENT, buf)

        # Set the modPath to the users documents folder
        modPath = buf.value + os.sep + "p2mm"
        modFilesPath = buf.value + os.sep + "p2mm\\ModFiles"
        configPath = buf.value + os.sep + "p2mm"
    elif (sys.platform.startswith("linux")):
        # Get the Linux systems session type, either X11 or Wayland
        linuxSessionType = os.environ.get("XDG_SESSION_TYPE")

        # Both Linux and Steam Deck/Steam OS 3.0 system platform names return as "linux"
        # We need to use the platform release name to differentiate a normal Linux distribution from Steam OS 3.0
        # Steam Deck uses SteamOS 3.0, which is built off Arch Linux, includes "valve" in the platform release.
        if ("valve" in platform.release()):
            iosd = True
            # Steam OS 3.0 has some directories set to read-only
            # We are going to install p2mm to the home\Documents directory instead of .config because of this
            modPath = os.path.expanduser("~") + os.sep + "Documents/p2mm"
            modFilesPath = os.path.expanduser("~") + os.sep + "Documents/p2mm/ModFiles"
            configPath = os.path.expanduser("~") + os.sep + "Documents/p2mm"
        else:
            iol = True
            # Set the modPath the to the users .config directory
            modPath = os.path.expanduser("~") + os.sep + ".config/p2mm"
            modFilesPath = os.path.expanduser("~") + os.sep + ".config/p2mm/ModFiles"
            configPath = os.path.expanduser("~") + os.sep + ".config/p2mm"
    else:
        # Feel sad for the poor people who are running templeOS :(
        print("\n")
        print("\
            QRQMQggggEDdEPbPbSX55UPPSIPSI5dZDKSIX55KgEPIS5ZZdSXSqIqEgdq5PPbXZPKqEbbK5KEbEPX5KqgDbSSPDdZPXqZEEbESSPgbK2X551IujJ2uII55qXqXDMZ\n\
            QRggDgZZddPPKqqbS2J1jPbZgEPbbBgqPQZUu5QMKbRQdBEKdQq2uZQZXgQgdDZQEZggggDQQgDRDQQPMQPPgBEDgMgBQZdRMgPgQDIdQEu1jjYYvYLYsujU2IUKZD5\n\
            QgMggZDdEbEPEEgdK2U1PB  dg  B:    qRSBr    IB     gPDD     Q.  d  B.    bX    .B2    7B     Ei     Q.    QD1211J1juJ115I5ISKEKS\n\
            ggggZZEZPZEZEDZbI2UIPB   q .B  M.  BPB  S7  I  Q: 1DBi  Q: B.  M  B. :d  K  B  B  7K  B  Jv  BZ  :Bb  B  :B1JjJuj1jUU225IS25SqI\n\
            MZDdEdZbdPEbDZDqIUS1XB     :B  B:  QDQ  ZL  B:  iQBUbQ.  rBB. .R  B.  . :P  :  B  sd  B     UBB  rBQDQB  .BJ1jjJujUU212252525XS\n\
            ggggDgZgZDdddgZqU5UjIB  .  :Q  B:  BdB  Ds  BB1i  jQSRRU:  B: .B  Q:  vsB5  ijbB  YZ  B  r: :BB  iBZ     KDYJ1u1JjuU12UIU5U55KI\n\
            MZgggZgEZdZEDDZII1usKB  R   B  5   BPB  s:  M  B  :BQv  B  Ir  2  B   BDBv  BBZB  :v  B  Ls  BB  :Bg  BMMZJYuJjJujUu21IU21UUKX5\n\
            ZZEgEZEZEZEgZgPS1UjU5B  Bv :BL   .gZuB2    EBi   .gbIB:   .BQ.   7B: .BUR1  DEUQb    XB  uJ .BQ  rBZ  gRIussYujUuU1U1U12UUjISq2\n\
            gEgEZdZEDZDEggdU1jU25KRgqdgPudQgQQbuUugQQRBd5gQRBQPuU5QQRRBSPQBMBRqgBg512EBQP121gBQQBRdQBMQQQXbQBDXqQRquIU1JjjUu1uUu212uUjuIqS5\n\
            ggDgZDDDZgZgDRKUu2UIujYL7v7LYJJ52212U2uU25121ujI2212u215U2u2U22SU2UU1U1I12UIU2U2U5IX25ISIS2IIS25II2211YYs1j1JuuUjujUu112jjsKXKI\n\
            RddbgDgggZgDQgKjUU51JYLvvvsJUu2UIU212uujUj1jU1111uUj11U1Uu2UI121U1IU2U21212U2UI1IUI2I25IS25IS2SI525UIuj7LL1u1J111u1uUuuu1Y1XPXS\n\
            RMPPZRgRgMgMRg2115jJvv7vvsj11I252I121Uu1u1j11Uj1uUu1uUu21U1UUI1UU2UU121I121U121IUIUI15U5IS2IU52I2I2IU2usvss1juJ1jUj1uUu1JYUPXPI\n\
            QMRbDgRgRMMgQE212jsvv777JJ21IU2U51U12u1sJj1j1J1u1u1J1uUuU12u212uI1Uu21212uU11uU1215UI25UIU52I25U5U2uU11juYjjuJuj2u1juj1jJvXKPK5\n\
            RRMRDRMggMgQQbu1JLv77Lvu1I1IU2U2UIUU1UJJYjJuJ1j1j1j1juJ11U11uUu21212uUuU1UUIU21I1I1UUI1I1IUIUI2IUUj1jujujJYuJjJ2u1j1j1juLuqPXPI\n\
            QgQRRgMggZgQQKuLvr77YYU1Uu2UI122I2512u1sjYuJuJ1juj1j1uuJuj1u1uujujuJ1u1j11212U21I12U21I12UI252I12uUuusuj1sJJuJuuUj1JUuuLvIdqqK5\n\
            RRMQMgEZbDEgZSvv7YvjuU12uUUIUI2IU5UI1I1JsJYusujuuuJuJuJuj1juj1JuJjYJYJJjsuJ1J11212UIUI2222U21U1I11u1suJuJjYujujUjuj1uusvvPPPKP5\n\
            QgQQQdbPZZDDq7vYJj1121UuU2I1IUI25ISU212jjYssJsuJuJuJ1jus1J1j1juJjsJYsLsvYLYYJYjs1uUuU1212U21Iu112uUuuYJYsLssuJuuuJ1juJY7UdbKPKX\n\
            RRQQggEgZggZYsj212uU1U12UI2I12U215I52IUIJjJjsJsujuJujuJuj1uuj1u1jUJuJjYYLsvYvYvsYJs1uU11121211uUjuuussLsYsYjsjJ1Juu1Js7vPEPPKPS\n\
            QMMDgdZZZZD1sJ2UU1UUUU212U2U2uU1XSX25U222sJYJsJJjJ1juJujuj1uUuU1U1uu1jjYsLYvLvLvYvsYujUu1u1uUjuJjJjsJYsYJsssuJuu1JuJJv7UZqPKPPX\n\
            MgZZdZEZdMqsYU121U1UuUjUu1J215IPdZPXU5125IvJJusjJjJ1juj1u1j1u1u11UuUu1j1ssLYLLvYvLLYYJYuJ1JuJusjsjsJLsvssJYjsju1juJuL7vEdPKPqPS\n\
            gEDEgEDdDZ5vJjuuUu1u1j1jIIqqddggRgZX555uIdKLYYuJjj1juu1j11U11u1u1uUu1u1uujJYsLsvYvLvYLYYJsussYsYJYsYsLsLsLJsJjuJuJjs7rqdbPPqPPK\n\
            ggZgZDEDZD2Jj212u2US2XXPdRMQRQRQRgS5IX2UjbQPYLYJYjjuJuJ1uUu2uU11uUjuj1u1uuJjYJYsvYLYLJLYLJssYsLsLYYsYsLsLjYjJUj1JuYvr2ZEPPqPqbX\n\
            DDMZgZDbZEDdbPbqPPEdDDMMQQQQQRRgE52122X1jUgBRIjYJsjJ1J1j11U12uUuU11juj1uuj1JusjYsLYLsLsLsYsYYLYvYvYvYLsYJsjJujUjuYLrsZZPPqPPPPK\n\
            PPDRZDEEbgQQggDMgRgMgQQBQBQQggPKI5U21IIIu1IgBBZX1jsjs1juj2u1uUj1jUu1JujujuJuuUuuJJLsvsLsLYLYvYvYvsvsLsLss1j1j1juYYrvbDPPqPKPKPS\n\
            ZPEDQgMEZgQQQMQRQRQQQQBQQMgbPS5UIU21U1I2Uj1jqQBQMPS1ujuJuu1uUuus1j1J1sjYJsuJU12uUjussLsLsvLvYvL7LLYLsLsY1u1j1j1YYr7PgPbPPqPKqSP\n\
            EEbdZBQMdDgQQQQQQQQQMRddbKISU52I1U1Uu2U5UU1ULJKQBBMDPPS5U2jUjujUUU1U12111ujjj1uUUUjjJsYsLYvvvL7v7LvsYsYuuUuUuUss77KgPPqPqq5XPQQ\n\
            ZPDddZQgZdgRBQQggdPSK2IUI1IUI2212u2UUu225U222JJjdQBQQgMEZPdPdEDZMDgZZdZZZKK221Uu2u2uussLYvv7Lvv7LvYLJYju21Uu1jj77XgbPqPXXXdQBBZ\n\
            dEdZbEdZEZdDgQQgK2uI1U1IU5U52IUIU212UU122UUI2IjjYIPQQBQQRRQQRQQQQQQQRQMQgMEZPPSIU21IuuYsvv7v7v7v7LvJYuu2u211sJrvKgbPKPSKEBBBZP2\n\
            ZPZdDdDdDEZdgDRgKu12IUIUI12U52IU52IU21I1IU2UIU5U1JuUPDQQBQQQQMMggDMgggMgMgMggDDPKU212uuYY7v7v7v7vvsY1uI1UUUjJ7LPDPPqqSZQBBDXKKX\n\
            EEEDEDEZEDEDZDDgZKJuuIUI25UIUI2IU5UIUUu212u2UIII221uYu1PdggQQBBBQQMQMRgMgMgMggDDdPIUUIjJvLv7777vvYY1uUU2u2js7JdgbPKqdBBBdqSKqPX\n\
            gdDEDEDEDEDZgDgDggdUJsUUI2SI5U5U2U2U21IUIU21I2S25U212JusUuIIPPZgBBBBBBBRRMMgRggDgEPI511sJvv7v777vYu1I25UUJv75ZgPPKDQBQZKKKPqPPq\n\
            EdEZdZZDEDZgZgDgDMMQbIs11525I52I2IUI2I2I1U1Uu5S52I1IUI1IU2u21112UXXbZQQBBBQQMRggggdP5IuusY7v777vLju2UI2UJvvPgDqPEBBBEqSPqPqPPbX\n\
            DdZEZEDEZZDZgDgDgDggQME2uJ21II55SI5I5I5IIu1u2US5I25UI25252I2IU22211J1jISdRBBBQQgRDDqKI2uJvv7777vJuI25UuLv1DgZPZQBBgqKKPKPqbPPPq\n\
            DZZZEDEDZgDgggDgDgDgDRRQbIYYJ5SPXX2SI5ISIUu21S5SII25252S25I5252525U21I11J2IdDQQQQQggPKU1YL77r7vsuI25usvuPQDdbQBBgPKPqbPPPbPPPbX\n\
            DdDEDZDZgZgZgDMDgDgDMgggQMEXQBBBBBgPKI5IS1Uu2ISISISISIXIS5S55ISIS25UI25221U1I5PdgRQMgqIjsvv777YJI2UsuXDgREZRBBQPPPbPbPbPPPPPPPK\n\
            DZEDEgZgDgDgDMDgDggMgMDMgBBBQE2KbBQBBMqK52jUuS5S555S5SSS5XSS5X5S5X5S2I25252I12122PEMgZIuvv777YJ21ujPBBQQgQBBBDPbPdbdPbPdbdPbPbK\n\
            gEgZDDgZggMDggMgMDgDMgMgMMBBY.:vbZDQBBBRPUuu2IX5X5X5X5KIS5XISSXSXSX5XIS25UI2SUI122XqZEquYvvrLsUU1qBBBBBBBBBZEPEdDbEPdbbPdPdPdPP\n\
            DDEgZgDgZMgMgMgRgggMgMgMgQBU.iiLDgdQBBBBQSL115SS5S5X5KSKXPPEEZPbXKSKSK5SI5252I22UI15KdX2Lv7vL1JsdBBQKJruQBDZdDdZdEbEPdbdPdbdPdK\n\
            gEgZgZggggggggRgQgRgRMRgRBB:.r7iPBBQgLiKBELJI5K5S5XSKSPbRBBBBBBBBQREPSS5SISIIU5252IISKXjY777ssLvddIL7r7JDgDEgEDdEdZdEbEPEbdPdbP\n\
            DgggDgDMgMgRgRgRgQgQgQRQQBM.:isQBBQBPJrqQR7u2XXX5XSqKdDBQgq5IdMBQBQBBBDP55IXI5IXI55X5K2Jv7rvL2KDP5s1UXbQMgDgZDZDEDdEbdddbdPdPEq\n\
            MZggMggDMgMgRgQgQgQgQRMDBBD:.:URRQBBBQBBBDvsI5K5X5KXdgBPJ7r75dgDQQBBBBBBMqKSXSS5XIX5X21L7i7sqgREXSbPPbQQQggDgDDZDEZdZdZdEPEbEbP\n\
            gDDgDggMgMgRgRMQMQMRDDgBQPDD7:7gMPPRMRRBBP712X5S5SXbEQPLr::SQgdQQQMggBBBBBPKSq5X5XXK55svirsbZES1UDPXdQQQRMggDgZgZDEDEZEEdZdEbZP\n\
            MDggMgMgRMRMQRQQRDDZQQBBXrIDMqjvKdDggZMQBsvUS5X5S5qPQM17r:rqQQBQXuPQQQQDQQBdqXKXPqPXSuLrrLqPPIuubKPQBBQgMgMgMDgZgZDEDEDdZdEdDdP\n\
            gMgRgMgMgRMQRQggEgQBBBBBY7JXPZgDqdEEdZDgU7Y55K5SISXEQZv7irqBRBBPrivQQQgPSRBBPS2XXPXKuLrrLPEEqKKPXDBBQBBBRgZMgRggDgDDZgEDEZdZdDP\n\
            RgRgRgRgQRQggZMQBBBBBQBBJ7jUqPEbZEDDgZdu771UXSS2S5PdQPv7rrbBBBBRddQBBQQ1v2BQP1uJ1sJJYri7PRZKKKqPQBBBBBBBBBQZDDgggZgEgZgEDdDdZZd\n\
            gggMMRRQggdgMBBBBBBBQBQB1vsUUXKbPdbbP5Jv7s1I5X255KSPRMv7rr2BQQQBBBBBQBd7:7DQIsvL77r7rirs5bujuXDBBBQBQBQQQBBBQgEggggMggZDEgEDZgP\n\
            RgQRQRQDMQBBBBBBBQBQBQBBKrsJ112UI11Jjvv7Lj5IKSX5KXqKEQEvr:rSRdXXddEZQbvir2g5Y77r7rrrii1juJ2qgQBQQQQQQQQQQQBBBBQDZEggMDgDgZgZDDE\n\
            MQRMDdUDQBBBBBBBBBBBBBBBZvLujUuuJJLYvL7YjS5qSKXqKPPPqZggSsriLdPqXEggKuJqgQXL77rrrrrri7LIEBBBBBRQQQRQQQQQQQQBQBQBQRdZDMggggZgZgb\n\
            RZEdQgJJKbDdZgQQBQRggZEZDJJjUuuj1sJvL7YuSXKSK5X5XKPPdbZEggMPXSZgRgMbqqEPqUJv777rrrri:rZBBBQRQRQRQQQRQQQQQQQQBQBQBBBRZPggggMggDZ\n\
            bDRBQBBMKKKPPEdEqPPDZZdDgSv1UIISusvL7Yu5SKXPSX5S2XKbPbdZbPPZZZbdqPqPXKSS1Jvv77rrrri:7BQBMRRQgQRQMQRQQQQQRQQQQBQBQBQBBQEEZggMggE\n\
            BQBQBBBBBgq5PZRMDqKXPPdZQdJjSIIsYvLvsUS5XSKSX5SI5USSKKPPZddPEPPPPqPPPKSjsvL77rrrriiIBQQgMMRgRMQMQMQRQRQRQQQQQQQQBQBQBBBQgPEgQMD\n\
            QBQBQBQQQRQBgEPdDMggZPUPMZj2X5YYvYvJUS5XSqXK5XISISI5IXIS5KXPqPqPKq5SUuYsvLvv7777rrSBBQMQgRgQMQRQRQRQRQMQQQQQRQQQQQQQQBQBBBgEdMD\n\
            BQBQBQQQQRBBBQQZZPZDQBBBBM5jUYYvLvYUXI55KSKSXSS2SISI5UIU2UIUIUI2IU1J1j1JjsJYsvsv75BgggggQgMgRMRMRgRMQgQRQMQQQRQQQQQQBQQQBBBQMEb\n\
            QQQQQQQQMRQBQBQQQRMQQBQBBBXsYYvLvYj52II5IXIS25I5IX5SIIU2121I222IUIUIU525UI11uUJLjQDPbZ1dgQRMgRgMgRgRMQRQRQQQRQQQRQQQQQQQQBQBBBg\n\
            QQQQQQQMQMQQQQQMgdgDgZggBZJvYvLvsjS2U111U12U215USIX5SI5U525I52SISIS5S5XI525I51YvdDEgBS2PPbMgRgRMRgQMQQBBBQQRQRQRQRQQQQBQQQQQBBB\n\
            QQQQQQQQMRMQQBQQDDbEbEdQgj7LvLvJJ211suJusjJjuU12252SSSII25IX5X5X5XSKSXIXI522uJ75gBQBEuEREdPZgQMQMRMQRZIbMBQQRQRQRQQBRQQQQBQQQBR\n\
            QRQRQQQQQMQMQQBRMEZdEPDgS7vvLvJjUujYYLsLLvYLsYuu2U525IXIS2SIS5XSS5KSX5S2IU2jYr1IYKBR2qDbZPdPddggQMQDEDq 7BQRQRQRQQQRQQQQQQBQQQQ\n\
            QQRQRQRQQQMRgQQQggEEbdZDLvvLvJs1Jsvv7v77r77vvsJUu1j11KSXI5IX5XSSSK5X552IU2jYrYD5:ruKKRPPPbPPqbPdbZPqMBJ PBQQQQRQRQRQQQQQQQQBQBR\n\
            QQQRQMQQQRQRMgQQREZdDERSvvYvsYuYL77r7rrrrrv7LYJYJYss5KqXXSXI55X5XSSISI2UUjJr7MBgIuU1XSqqPPdPPPDgQMgQBZrJBQQgQMQMQMQQQQQRQQQQQQQ\n\
            QQRQRQMQMQRQgQMQQbKbdRDj7vvYLJLv77rrrriiir7vvYvLvLvuSqSqXK5S5S5SIX5S2212JJrrKBBQJ2PPSS5qqPqdPPPDgBBBg21MQQRQMQRQRQRQQQRQQQQBQBM\n\
            QMQMQMRMRRQgRgRgQgggBEjrv7LvLvv77rriiiiirr77vvLvYvsIPqPKKXXIX5SIX55II1UJs7i2BQBQDudgEPKSPKPqdbEqPqZgDEBgMMQQQRQMQMQRQRQQQQQQQQQ\n\
            QQQQMQgRMRMRMRMQgQQBgu777v7777rririiiiiir77v7v7vLu5PKqXKXK5S5X5XISIIu1Js7iYBBQQQQDgBggddPbPdbEbZdEPbPdbPKEgQMQRQRQRQRQQQRQQQQBQ\n\
            QRQRQRQMRgRMRMRMRQBSs7v77r7r7rriiiiiiirr7777vvjuXPbqqKPXqXXISIXIS22juLs7r7QQBRQQBQBQBMgZDdEPZdEEDEEbZPPKPKPdMgRMQQQRQQQQQQQQQQQ\n\
            QQMQRQMRgRgRMRgRRM2rr7r7r7rrrriiiiiririr7YJUISXPKqSqSqXqXKS55S552UJJLY7rrgBBBBQQRQQBQBRQDgZZdZEgEgZDEDEEPbPPPdgRgQQQQBQQQQQQQBM\n\
            QRQMRMRgQgRgRgRgQDYrJL777r7rriiirirrrr7vU5qXX221U12US5XSKKXIS2SUUsJvY7rrdBBQBQBQBQBQBQBQQMRDggggMDgggZgZDddbEPbdggRDRQBQQQQQQQQ\n\
            QQMQgRgQgRgRgRggRBQSJUujv7rrrrirrrr77J1XI2JJLLvLLYs1jIIKXqSSIXUUsJLYv7rPBBQQQBQBQBQBQBQBQQQQRRMQRQMRggDgDZdZbdPbPDgQDgDQQBQQQBM\n\
            QRRgRgRgRgRgRgMgBBRquUS2UYv7v7v7vvJjI2Ijs77r7rrr7rvvJjIIXXK5X52jjLLv7rKBBQQQQQQQBQBQQQBQBQBQQQQRQMQgQRRggggZDEDEZPdDQRgbgQBQBQQ\n\
            RQMRMRgRgRgMgMZRBMERq22SIIjjJJsuJ222JL77rririiiirrr77YjIIqKKIIuussv7rSBBQQQQQQQQQBQBQQQBQBQBQBQBQQRMZgMQMMDgZgZgEZEDZRQBDEZQQBR\n\
            QMQMQMRgRgMgMDDQBDEgQZq5SIS255KKPKqUuYs777v7v77rrirr77JjIXKSS1uss77rXBBQQQQRQRBQQQBQBQQQQQQQBQBQBQBQQDEgQQQMMggDgDgZgDMQBQDbgRQ\n\
            RQgRgRMQgMgMggZBQMgQQBQRDMdUUKKqKdbDZZPPKXI5SqqdPKYri7vs1KXX2UJsv77SBBQQMQQQRQQQRQQQQBQBQBQQQBQBQBQBBBQMEQQQRQMRgMggDRgRQBBQggD\n\
            QRQMQgQMRgRgMDgQQMRRQQQQBBQjUIdZEqqKPqPXSuJLvr772PMD277LUSP5IuuLvvPBBQQRQMQRQQQRQRQQQQQQBQBQBQBQBQQQBBBBQgQQBQRMRMRgMggMQRQQBRZ\n\
            QQQBQQQBQQMRgQRQQQMRMQgMgQg11SbQQQgdKqXXI2usv7rri77SDPLL1qKXU1YvLqgBBQgMMRMQMQQQRQQQQQQBQBQBQBQBQBQQQQRQQBgRQBQQRQgQgRMQRQQQQBR\n\
            BDDDRgqEgggbEEDgQRQRRgMgRRZjUIdMQMQMMbqXPKqXKS51uLL7jKP12KP51sLsPDMMQZEPRRQMQQQQQQQRQRQQQQBQBQBQBQBQQQQRQQBQBQBQBQQQQRRMQQQQQQB\n\
            BdIP2IKKUZbEPPqgQRRQRQMQDDquuKdMgMgMgDXXSKKqXqXXI21JvL2q5K51Ls1PDgdEdZdDgQMRgRMQRQRQRQRQMQQBQBQBQQQQQQQQQBQBBBBBQBQBQBRQQQQBQBQ\n"
        )
        print("This operating system is not supported!", )
        print("We only support Windows, Linux, and Steam Deck/Steam OS 3.0 as of verison 2.2.0.")
        os._exit(1)

    # Check if the modPath exists, if not create it
    if not os.path.exists(modPath):
        os.makedirs(modPath)
    if not os.path.exists(configPath):
        os.makedirs(configPath)

def LoadConfig() -> None:
    global configData
    configData = CFG.ImportConfig()
    Log("Config data loaded!")