extends CanvasLayer

var time_started = 0.0

var scores = []
var username = ""
var someone_won = false

func hided():
	$UI/PanelContainer2.visible = false
	$UI/current_time.visible = true
	$TextEdit.text = ""
	
func _process(delta: float) -> void:
	time_started += delta
	$UI/current_time.text = str(snapped(time_started, .1))

	
func start():
	time_started = 0.0


func test2():
	$UI/TextureRect.visible = false
	$UI/newhighscore.visible = false
	$UI/PanelContainer.visible = false
	

func test():
	if someone_won:
		$UI/PanelContainer2.visible = true
		$UI/PanelContainer.visible = true
		$UI/newhighscore.visible = true
		$UI/TextureRect.visible = true
		$UI/current_time.visible = false
		$UI/TextureRect.visible = true
	scores.append(time_started)
	$UI/newhighscore.text = str(snapped(time_started, .1))
	$UI/newhighscore.visible = true
	time_started = 0.0
	scores.sort()
	scores.reverse()
	if scores.size() > 14:
		scores.resize(14)
	var score_text = "HIGH SCORES\n"
	for score in scores:
		score_text += str(snapped(score, .1)) + "\n"
	$UI/PanelContainer/highscore.text = score_text
	$UI/PanelContainer.visible = true


func gameover():
	$UI/TextureRect.visible = true
	
func all_enemies_killed():
	someone_won = true
	$TextEdit.visible = true
	$UI/TextureRect.visible = false
	scores.append(time_started)
	$UI/newhighscore.text = str(snapped(time_started, .1))
	$UI/newhighscore.visible = true
	time_started = 0.0
	scores.sort()
	scores.reverse()
	if scores.size() > 14:
		scores.resize(14)
	var score_text = "HIGH SCORES\n"
	for score in scores:
		score_text += str(snapped(score, .1)) + "\n"
	$UI/PanelContainer/highscore.text = score_text
	$UI/PanelContainer.visible = true
	$TextEdit.visible = true
	$UI/PanelContainer2.visible = true
	$UI/PanelContainer.visible = true
	$UI/newhighscore.visible = true
	$UI/TextureRect.visible = true
	$UI/current_time.visible = false
	$TextEdit.grab_focus()

func _on_text_edit_text_changed() -> void:
	if $TextEdit.text.length() > 8:
		$TextEdit.text = $TextEdit.text.substr(0, 8)
	if $TextEdit.text.contains("\n"):
		username = $TextEdit.text
		$TextEdit.visible = false
		if str(username).length() > 8:
			username = str(username).substr(0, 8)
		$UI/PanelContainer2/highscore.text += str(username).strip_edges() + "\n"
		$UI/PanelContainer2.visible = true
