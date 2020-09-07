extends Navigation

var inicio = Global.inicioAlvo
var fim = Global.fimAlvo
var caminho = []

func _ready():
	inicio = Global.inicioAlvo
	fim = Global.fimAlvo
	atualizacao()
	
func _physics_process(delta):
	inicio = Global.inicioAlvo
	fim = Global.fimAlvo
	atualizacao()

# Atualiza caminho a seguir
func atualizacao():
	var c = get_simple_path(inicio, fim, true)
	caminho = Array(c)
	caminho.invert()
	set_process(true)
	Global.caminhoSeguir = caminho
	
