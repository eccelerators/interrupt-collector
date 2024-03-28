Search.setIndex({"docnames": ["Eccelerators.Library.IP.InterruptCollectorIfc-composite", "InterruptCollectorIfc_c_code_preview", "InterruptCollectorIfc_python_code_preview", "InterruptCollectorIfc_simulation_code_preview", "InterruptCollectorIfc_usage", "index"], "filenames": ["Eccelerators.Library.IP.InterruptCollectorIfc-composite.rst", "InterruptCollectorIfc_c_code_preview.rst", "InterruptCollectorIfc_python_code_preview.rst", "InterruptCollectorIfc_simulation_code_preview.rst", "InterruptCollectorIfc_usage.rst", "index.rst"], "titles": ["Interrupt Collector Interface (InterruptCollectorIfc)", "Interrupt Collector C-Header preview", "Interrupt Collector Python code preview", "Interrupt Collector Simulation code preview", "<strong>Introduction</strong>", "Welcome to InterruptCollector\u2019s documentation!"], "terms": {"contain": [0, 4], "basic": 0, "address": [0, 1, 2, 4], "id": 0, "name": 0, "0x00": [0, 4], "async": 0, "busreset": 0, "asynchron": 0, "bu": [0, 3, 4], "thi": [0, 1, 2, 3, 4], "defin": [0, 1], "level": [0, 4], "trigger": [0, 4], "sourc": [0, 4], "usual": 0, "edg": [0, 4], "e": 0, "g": 0, "timer": 0, "puls": 0, "can": [0, 1, 2, 3, 4], "convert": 0, "ones": 0, "catch": 0, "them": 0, "user": [0, 4], "logic": [0, 4], "constraint": 0, "allow": [0, 4], "process": [0, 4], "multipl": [0, 4], "cpu": [0, 4], "without": [0, 4], "need": [0, 4], "spinlock": 0, "enabl": [0, 4], "forward": 0, "an": [0, 4], "": [0, 4], "each": [0, 4], "provid": 0, "control": [0, 4], "notifi": 0, "when": 0, "ha": 0, "been": 0, "start": [0, 4], "end": [0, 3, 4], "us": [0, 1, 2, 3, 4], "fo": 0, "do": 0, "write": [0, 3, 4], "read": [0, 4], "access": [0, 1, 2], "directli": 0, "receiv": 0, "data": 0, "uart": 0, "detail": 0, "0x0b": 0, "0x04": 0, "0x08": 0, "type": [0, 4], "descript": [0, 4], "03": 0, "rw": 0, "0x0": [0, 1, 2, 3], "interruptdis": 0, "i": [0, 1, 2, 3, 4], "0x1": 0, "interrupten": 0, "default": 0, "02": 0, "01": 0, "00": 0, "r": 0, "w": 0, "notpend": 0, "pend": 0, "notconfirm": 0, "effect": 0, "confirm": 0, "hw": [0, 2, 4], "recogn": 0, "sw": [0, 1, 4], "respect": [0, 4], "routin": [0, 4], "enter": 0, "The": [0, 1, 2, 3, 4], "isn": 0, "t": 0, "store": 0, "thu": [0, 1, 4], "0": [0, 1, 2, 3, 4], "again": [0, 4], "sole": 0, "action": 0, "suffici": 0, "init": 0, "impact": 0, "0b0": 0, "set": [0, 4], "after": [0, 4], "attach": 0, "interruptcollector": [0, 3], "inprocess": 0, "complet": [0, 4], "origin": [1, 2, 3], "file": [1, 2, 3, 4], "found": [1, 2, 3, 4], "gener": [1, 2, 3, 5], "src": [1, 2, 3, 4], "gen": [1, 2, 3, 4], "folder": [1, 2, 3, 4], "should": [1, 2, 3], "fw": 1, "develop": [1, 3, 4], "bit": [1, 4], "regist": [1, 4], "move": 1, "hx": [1, 2, 3, 5], "congruent": 1, "copyright": [1, 2, 3], "2024": [1, 2, 3], "ecceler": [1, 2, 3, 4], "gmbh": [1, 2, 3], "code": [1, 4, 5], "wa": [1, 2, 3], "compil": [1, 2, 3], "v0": [1, 2, 3], "0000000": [1, 2, 3], "extens": [1, 2, 3], "1": [1, 2, 3, 4], "24": 1, "85d98215": 1, "further": [1, 2, 3, 4], "inform": [1, 2, 3, 4], "http": [1, 2, 3], "com": [1, 2, 3, 4], "chang": [1, 2, 3, 4], "mai": [1, 2, 3, 4], "caus": [1, 2, 3, 4], "incorrect": [1, 2, 3, 4], "behavior": [1, 2, 3], "lost": [1, 2, 3], "regener": [1, 2, 3], "ifndef": 1, "_interruptcollectorifc_h": 1, "width": [1, 2], "valu": [1, 2], "mask": [1, 2, 4], "direct": [1, 2], "interruptcollectorifcaddressbuswidth": [1, 2, 3], "4": [1, 2, 3, 4], "interruptcollectorifcdatabuswidth": [1, 2, 3], "32": [1, 2, 3], "interruptcollectorblkaddress": [1, 2, 3], "interruptcollectorblks": [1, 2, 3], "0xc": [1, 2, 3], "interruptmaskregaddress": [1, 2, 3], "interruptmaskregwidth": [1, 2, 3], "mask3mask": [1, 2, 3], "0x00000008": [1, 2, 3], "mask3posit": [1, 2, 3], "3": [1, 2, 3], "mask3width": [1, 2, 3], "mask3_interruptdisabledmv": [1, 2, 3], "0x00000000": [1, 2, 3], "mask3_interruptenabledmv": [1, 2, 3], "mask3busresetmrstv": [1, 2, 3], "mask2mask": [1, 2, 3], "0x00000004": [1, 2, 3], "mask2posit": [1, 2, 3], "2": [1, 2, 3], "mask2width": [1, 2, 3], "mask2_interruptdisabledmv": [1, 2, 3], "mask2_interruptenabledmv": [1, 2, 3], "mask2busresetmrstv": [1, 2, 3], "mask1mask": [1, 2, 3], "0x00000002": [1, 2, 3], "mask1posit": [1, 2, 3], "mask1width": [1, 2, 3], "mask1_interruptdisabledmv": [1, 2, 3], "mask1_interruptenabledmv": [1, 2, 3], "mask1busresetmrstv": [1, 2, 3], "mask0mask": [1, 2, 3], "0x00000001": [1, 2, 3], "mask0posit": [1, 2, 3], "mask0width": [1, 2, 3], "mask0_interruptdisabledmv": [1, 2, 3], "mask0_interruptenabledmv": [1, 2, 3], "mask0busresetmrstv": [1, 2, 3], "interruptrequestregaddress": [1, 2, 3], "0x4": [1, 2, 3], "interruptrequestregwidth": [1, 2, 3], "request3mask": [1, 2, 3], "request3posit": [1, 2, 3], "request3width": [1, 2, 3], "request3_notpendingmv": [1, 2, 3], "request3_pendingmv": [1, 2, 3], "request3_notconfirmedmv": [1, 2, 3], "request3_confirmedmv": [1, 2, 3], "request3_asyncmrstv": [1, 2, 3], "request2mask": [1, 2, 3], "request2posit": [1, 2, 3], "request2width": [1, 2, 3], "request2_notpendingmv": [1, 2, 3], "request2_pendingmv": [1, 2, 3], "request2_notconfirmedmv": [1, 2, 3], "request2_confirmedmv": [1, 2, 3], "request2_asyncmrstv": [1, 2, 3], "request1mask": [1, 2, 3], "request1posit": [1, 2, 3], "request1width": [1, 2, 3], "request1_notpendingmv": [1, 2, 3], "request1_pendingmv": [1, 2, 3], "request1_notconfirmedmv": [1, 2, 3], "request1_confirmedmv": [1, 2, 3], "request1_asyncmrstv": [1, 2, 3], "request0mask": [1, 2, 3], "request0posit": [1, 2, 3], "request0width": [1, 2, 3], "request0_notpendingmv": [1, 2, 3], "request0_pendingmv": [1, 2, 3], "request0_notconfirmedmv": [1, 2, 3], "request0_confirmedmv": [1, 2, 3], "request0_asyncmrstv": [1, 2, 3], "interruptserviceregaddress": [1, 2, 3], "0x8": [1, 2, 3], "interruptserviceregwidth": [1, 2, 3], "service3mask": [1, 2, 3], "service3posit": [1, 2, 3], "service3width": [1, 2, 3], "service3_endedmv": [1, 2, 3], "service3_inprocessmv": [1, 2, 3], "service3_notconfirmedmv": [1, 2, 3], "service3_confirmedmv": [1, 2, 3], "service3_asyncmrstv": [1, 2, 3], "service2mask": [1, 2, 3], "service2posit": [1, 2, 3], "service2width": [1, 2, 3], "service2_endedmv": [1, 2, 3], "service2_inprocessmv": [1, 2, 3], "service2_notconfirmedmv": [1, 2, 3], "service2_confirmedmv": [1, 2, 3], "service2_asyncmrstv": [1, 2, 3], "service1mask": [1, 2, 3], "service1posit": [1, 2, 3], "service1width": [1, 2, 3], "service1_endedmv": [1, 2, 3], "service1_inprocessmv": [1, 2, 3], "service1_notconfirmedmv": [1, 2, 3], "service1_confirmedmv": [1, 2, 3], "service1_asyncmrstv": [1, 2, 3], "service0mask": [1, 2, 3], "service0posit": [1, 2, 3], "service0width": [1, 2, 3], "service0_endedmv": [1, 2, 3], "service0_inprocessmv": [1, 2, 3], "service0_notconfirmedmv": [1, 2, 3], "service0_confirmedmv": [1, 2, 3], "service0_asyncmrstv": [1, 2, 3], "endif": 1, "togeth": 2, "simstm2pi": 2, "run": [2, 4], "simstm": [2, 3, 4], "test": [2, 4], "real": [2, 4], "target": 2, "c": [2, 3, 4, 5], "7": 2, "62bb9ef4": 2, "class": 2, "interruptcollectorblk": [2, 5], "properti": 2, "def": 2, "self": 2, "return": 2, "It": [3, 4], "complement": 3, "tb": [3, 4], "repositori": [3, 4], "hdl": 3, "testbench": [3, 5], "oper": [3, 4], "entri": 3, "point": [3, 4], "testmain": 3, "stm": [3, 4], "12": 3, "d6fdbb9b": 3, "librari": 3, "ip": [3, 4], "const": 3, "var": 3, "interruptcollectorifcaddress": 3, "interruptcollectorifcbu": 3, "interruptcollectorifcinit": 3, "proc": [3, 4], "equ": 3, "add": 3, "call": 3, "interruptcollectorblkinit": 3, "rvalinterruptcollectorblk_busreset": 3, "resettestinterruptcollectorblkbybusreset": 3, "verifi": 3, "rbvlinterruptcollectorblk": 3, "readbacktestinterruptcollectorblk": 3, "interrupt": [4, 5], "connect": 4, "veri": 4, "close": 4, "thei": 4, "requir": 4, "carefulli": 4, "plan": 4, "concept": 4, "from": 4, "which": 4, "event": 4, "through": 4, "differ": 4, "collector": [4, 5], "locat": 4, "both": 4, "outsid": 4, "insid": 4, "system": 4, "extend": 4, "its": 4, "driver": 4, "up": 4, "applic": 4, "depend": 4, "specif": 4, "natur": 4, "all": 4, "compon": 4, "chain": 4, "dramat": 4, "affect": 4, "time": 4, "capabl": 4, "overal": 4, "perform": 4, "A": 4, "design": 4, "peripher": 4, "block": [4, 5], "often": 4, "issu": 4, "attent": 4, "typic": 4, "more": 4, "than": 4, "one": 4, "present": 4, "here": 4, "proven": 4, "solut": 4, "manag": 4, "task": 4, "doe": 4, "impos": 4, "excess": 4, "overhead": 4, "tini": 4, "microcontrol": 4, "suitabl": 4, "most": 4, "complex": 4, "chip": 4, "soc": 4, "core": 4, "symmetr": 4, "asymmetr": 4, "multiprocess": 4, "mode": 4, "reus": 4, "across": 4, "wide": 4, "rang": 4, "subsequ": 4, "chapter": 4, "structur": 4, "top": 4, "down": 4, "manner": 4, "includ": 4, "progress": 4, "intern": 4, "immedi": 4, "either": 4, "ant": 4, "script": 4, "For": 4, "see": 4, "quick": 4, "section": 4, "vhdl": 4, "along": 4, "other": 4, "liber": 4, "under": 4, "mit": 4, "licens": 4, "ani": 4, "distinct": 4, "evid": 4, "mean": 4, "stai": 4, "activ": 4, "long": 4, "signal": 4, "condit": 4, "persist": 4, "contrast": 4, "initi": 4, "due": 4, "state": 4, "like": 4, "transit": 4, "low": 4, "high": 4, "vice": 4, "versa": 4, "emploi": 4, "addit": 4, "catcher": 4, "transform": 4, "therebi": 4, "ensur": 4, "compat": 4, "consist": 4, "two": 4, "part": 4, "first": 4, "tool": 4, "servic": 4, "request": 4, "languag": 4, "input": 4, "output": 4, "implement": 4, "necessari": 4, "second": 4, "simultan": 4, "within": 4, "same": 4, "processor": 4, "multiprocessor": 4, "synchron": 4, "measur": 4, "spin": 4, "lock": 4, "accompani": 4, "diagram": 4, "illustr": 4, "wishbon": 4, "lead": 4, "demonstr": 4, "realiz": 4, "ar": 4, "scalabl": 4, "term": 4, "number": 4, "overview": 4, "upon": 4, "arriv": 4, "execut": 4, "exactli": 4, "select": 4, "report": 4, "acknowledg": 4, "correspond": 4, "reset": 4, "appear": 4, "onli": 4, "actual": 4, "disabl": 4, "line": 4, "briefli": 4, "deactiv": 4, "prioriti": 4, "synchroni": 4, "individu": 4, "adjust": 4, "show": 4, "devic": 4, "dut": 4, "our": 4, "red": 4, "border": 4, "On": 4, "left": 4, "instanc": 4, "shown": 4, "main": 4, "differenti": 4, "base": 4, "cross": 4, "mock": 4, "buse": 4, "merg": 4, "via": 4, "join": 4, "unit": 4, "form": 4, "common": 4, "split": 4, "area": 4, "anoth": 4, "deleg": 4, "creat": 4, "four": 4, "programm": 4, "must": 4, "count": 4, "refer": 4, "miss": 4, "record": 4, "per": 4, "failur": 4, "fault": 4, "generatorfailur": 4, "deliv": 4, "entir": 4, "These": 4, "evenli": 4, "distribut": 4, "dispatch": 4, "short": 4, "glanc": 4, "program": 4, "snippet": 4, "In": 4, "articl": 4, "we": 4, "focuss": 4, "rather": 4, "fpga": 4, "consequ": 4, "instead": 4, "bitstream": 4, "purpos": 4, "framework": 4, "To": 4, "begin": 4, "util": 4, "variou": 4, "artifact": 4, "document": 4, "ve": 4, "linux": 4, "environ": 4, "ubuntu": 4, "22": 4, "04": 4, "step": 4, "involv": 4, "instal": 4, "sudo": 4, "apt": 4, "get": 4, "y": 4, "next": 4, "clone": 4, "git": 4, "recurs": 4, "submodul": 4, "github": 4, "now": 4, "have": 4, "valid": 4, "evalu": 4, "cd": 4, "otherwis": 4, "alreadi": 4, "assum": 4, "later": 4, "sh": 4, "success": 4, "yield": 4, "similar": 4, "core1": 4, "current": 4, "total": 4, "0x0360": 4, "source0": 4, "0x0142": 4, "source1": 4, "0xee": 4, "source2": 4, "0xb3": 4, "source3": 4, "0x7d": 4, "core0": 4, "0x0380": 4, "0x013e": 4, "0xff": 4, "0xc0": 4, "0x83": 4, "0x0101": 4, "final": 4, "finish": 4, "actualsum": 4, "0x0700": 4, "actual0": 4, "0x0280": 4, "actual1": 4, "0x0200": 4, "actual2": 4, "0x0180": 4, "actual3": 4, "0x0100": 4, "failuresum": 4, "failures0": 4, "failures1": 4, "failures2": 4, "failures3": 4, "tb_simstm": 4, "vhd": 4, "1245": 4, "21": 4, "773216100p": 4, "assert": 4, "note": 4, "error": 4, "work": 4, "tb_top_wishbon": 4, "info": 4, "stop": 4, "9990391400p": 4, "modelsim_wishbon": 4, "possibli": 4, "path": 4, "adapt": 4, "build": 4, "xml": 4, "window": 4, "command": 4, "starter": 4, "edit": 4, "take": 4, "5": 4, "minut": 4, "until": 4, "size": 4, "773216100": 4, "p": 4, "iter": 4, "i0_tb_simstm": 4, "leav": 4, "halt": 4, "195": 4, "end_proc": 4, "testmainwishbon": 4, "1000790207100": 4, "i1_tb_simstm": 4, "python": [4, 5], "html": 4, "pdf": 4, "place": 4, "appli": 4, "testament": 4, "advanc": 4, "technolog": 4, "stride": 4, "realm": 4, "comput": 4, "pivot": 4, "craft": 4, "effici": 4, "innov": 4, "crucial": 4, "evolut": 4, "field": 4, "embed": 4, "avail": 4, "feel": 4, "free": 4, "reinvent": 4, "wheel": 4, "introduct": 5, "function": 5, "simul": 5, "ghdl": 5, "modelsim": 5, "hardwar": 5, "softwar": 5, "interfac": 5, "conclus": 5, "interruptcollectorifc": 5, "header": 5, "preview": 5, "index": 5, "search": 5, "page": 5}, "objects": {}, "objtypes": {}, "objnames": {}, "titleterms": {"interrupt": [0, 1, 2, 3], "collector": [0, 1, 2, 3], "interfac": [0, 4], "interruptcollectorifc": 0, "block": 0, "reset": 0, "interruptcollectorblk": 0, "regist": 0, "deleg": 0, "mask": 0, "interruptmaskreg": 0, "bit": 0, "valu": 0, "mask3": 0, "mask2": 0, "mask1": 0, "mask0": 0, "request": 0, "interruptrequestreg": 0, "request3": 0, "request2": 0, "request1": 0, "request0": 0, "servic": 0, "interruptservicereg": 0, "service3": 0, "service2": 0, "service1": 0, "service0": 0, "content": [1, 4, 5], "c": 1, "header": 1, "preview": [1, 2, 3], "python": 2, "code": [2, 3], "simul": [3, 4], "introduct": 4, "function": 4, "testbench": 4, "gener": 4, "ghdl": 4, "modelsim": 4, "hx": 4, "hardwar": 4, "softwar": 4, "conclus": 4, "welcom": 5, "interruptcollector": 5, "": 5, "document": 5, "indic": 5, "tabl": 5}, "envversion": {"sphinx.domains.c": 3, "sphinx.domains.changeset": 1, "sphinx.domains.citation": 1, "sphinx.domains.cpp": 9, "sphinx.domains.index": 1, "sphinx.domains.javascript": 3, "sphinx.domains.math": 2, "sphinx.domains.python": 4, "sphinx.domains.rst": 2, "sphinx.domains.std": 2, "sphinx": 60}, "alltitles": {"Interrupt Collector Interface (InterruptCollectorIfc)": [[0, "interrupt-collector-interface-interruptcollectorifc"]], "Blocks of Interrupt Collector Interface": [[0, "id1"]], "Resets of Interrupt Collector Interface": [[0, "id2"]], "Interrupt Collector Block (InterruptCollectorBlk)": [[0, "interrupt-collector-block-interruptcollectorblk"]], "Registers or Delegates of Interrupt Collector Block": [[0, "id4"]], "Interrupt Mask Register (InterruptMaskReg)": [[0, "interrupt-mask-register-interruptmaskreg"]], "Bits of Interrupt Mask Register": [[0, "id5"]], "Values of Mask3": [[0, "id6"]], "Resets of Mask3": [[0, "id7"]], "Values of Mask2": [[0, "id8"]], "Resets of Mask2": [[0, "id9"]], "Values of Mask1": [[0, "id10"]], "Resets of Mask1": [[0, "id11"]], "Values of Mask0": [[0, "id12"]], "Resets of Mask0": [[0, "id13"]], "Interrupt Request Register (InterruptRequestReg)": [[0, "interrupt-request-register-interruptrequestreg"]], "Bits of Interrupt Request Register": [[0, "id14"]], "Values of Request3": [[0, "id15"]], "Resets of Request3": [[0, "id16"]], "Values of Request2": [[0, "id17"]], "Resets of Request2": [[0, "id18"]], "Values of Request1": [[0, "id19"]], "Resets of Request1": [[0, "id20"]], "Values of Request0": [[0, "id21"]], "Resets of Request0": [[0, "id22"]], "Interrupt Service Register (InterruptServiceReg)": [[0, "interrupt-service-register-interruptservicereg"]], "Bits of Interrupt Service Register": [[0, "id23"]], "Values of Service3": [[0, "id24"]], "Resets of Service3": [[0, "id25"]], "Values of Service2": [[0, "id26"]], "Resets of Service2": [[0, "id27"]], "Values of Service1": [[0, "id28"]], "Resets of Service1": [[0, "id29"]], "Values of Service0": [[0, "id30"]], "Resets of Service0": [[0, "id31"]], "Contents": [[1, "contents"], [4, "contents"]], "Interrupt Collector C-Header preview": [[1, "interrupt-collector-c-header-preview"]], "Interrupt Collector Python code preview": [[2, "interrupt-collector-python-code-preview"]], "Interrupt Collector Simulation code preview": [[3, "interrupt-collector-simulation-code-preview"]], "Introduction": [[4, "introduction"]], "Functionality": [[4, "functionality"]], "Testbench": [[4, "testbench"]], "Simulation": [[4, "simulation"]], "General": [[4, "general"]], "GHDL": [[4, "ghdl"]], "ModelSim": [[4, "modelsim"]], "HxS - Hardware/Software interface": [[4, "hxs-hardware-software-interface"]], "Conclusion": [[4, "conclusion"]], "Welcome to InterruptCollector\u2019s documentation!": [[5, "welcome-to-interruptcollector-s-documentation"]], "Contents:": [[5, null]], "Indices and tables": [[5, "indices-and-tables"]]}, "indexentries": {}})