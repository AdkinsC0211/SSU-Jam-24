extends StaticBody3D


func interact(body: CharacterBody3D) -> void:
	print("interact", body)

func display_message() -> String:
	return "Press E to Interact"
