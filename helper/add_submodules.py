from git import Repo, Submodule

repo = Repo('.')

submodule_list = [
   # [ "break-docbook-program-listing", "submodules/break-docbook-program-listing", "https://github.com/eccelerators/break-docbook-program-listing.git" ],
   # [ "sphinx-template", "submodules/sphinx-template", "https://github.com/eccelerators/sphinx-template.git" ],
   # [ "sphinx_docbook", "submodules/sphinx_docbook", "https://github.com/eccelerators/sphinx_docbook.git" ],
   # [ "eccelerators-docbook", "submodules/eccelerators-docbook", "https://github.com/eccelerators/eccelerators-docbook.git" ],
   # [ "basic-ant-builds", "submodules/basic-ant-builds", "https://github.com/eccelerators/basic-ant-builds.git" ],
   # [ "vhdl-eccelerators-basic-package", "submodules/vhdl-eccelerators-basic-package", "https://github.com/eccelerators/vhdl-eccelerators-basic-package.git" ],
   # [ "usual-objects", "submodules/usual-objects", "https://github.com/eccelerators/usual-objects.git" ],
   # [ "collect-fpga-build-results.git", "submodules/collect-fpga-build-results.git", "https://github.com/eccelerators/collect-fpga-build-results.git"],
   # [ "simstm", "submodules/simstm", "https://github.com/eccelerators/simstm.git" ],
   # [ "setup2modelsim", "submodules/setup2modelsim", "https://github.com/eccelerators/setup2modelsim.git" ],
   # [ "setup2ghdl", "submodules/setup2ghdl", "https://github.com/eccelerators/setup2ghdl.git" ],
   # [ "setup2vivado", "submodules/setup2vivado", "https://github.com/eccelerators/setup2vivado.git" ],
   # [ "interrupt-generator", "submodules/interrupt-generator", "https://github.com/eccelerators/interrupt-generator.git" ],
   # [ "bus-divider", "submodules/bus-divider", "https://github.com/eccelerators/bus-divider.git" ],
   # [ "bus-join", "submodules/bus-join", "https://github.com/eccelerators/bus-join.git" ],
   # [ "interrupt-dispatcher", "submodules/interrupt-dispatcher", "https://github.com/eccelerators/interrupt-dispatcher.git" ],
   # [ "interrupt-generator", "submodules/interrupt-generator", "https://github.com/eccelerators/interrupt-generator.git" ],
]


for m in submodule_list:
    Submodule.add(repo, m[0], m[1], m[2])
    
    