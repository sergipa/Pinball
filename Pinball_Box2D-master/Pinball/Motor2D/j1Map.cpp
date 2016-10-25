#include "p2Defs.h"
#include "p2Log.h"
#include "j1App.h"
#include "j1Render.h"
#include "j1FileSystem.h"
#include "j1Textures.h"
#include "j1Map.h"
#include <math.h>
#include "j1Physics.h"
#include "j1Input.h"

j1Map::j1Map() : j1Module()
{
	name.create("map");
}

// Destructor
j1Map::~j1Map()
{}

// Called before render is available
bool j1Map::Awake(pugi::xml_node& config)
{
	bool ret = true;


	return ret;
}

bool j1Map::PostUpdate() {
	if (App->input->GetKey(SDL_SCANCODE_SPACE) == KEY_DOWN) {
		b2Vec2 force(0.0f, -100.0f);
		b2Vec2 ball_pos(ball->pb->body->GetWorldCenter());
		ball->pb->body->ApplyForce(force, ball_pos,true);
	}
	return true;
}
bool j1Map::Start()
{
	bool ret = true;
	
	// Background 1
	bg1 = new Sprite(App->tex->Load("images/Background.png"), 0, 0, 395, 537, 0, 0);
	//Ball
	ball = new Sprite(App->tex->Load("images/Ball.png"), 0, 0, 16, 16);

	//Bouncing Circles
	bouncing_circle1 = new Sprite(App->tex->Load("images/Ball.png"), 0, 0, 62, 62);
	bouncing_circle2 = new Sprite(App->tex->Load("images/Ball.png"), 0, 0, 62, 62);
	bouncing_circle3 = new Sprite(App->tex->Load("images/Ball.png"), 0, 0, 62, 62);

	return ret;
}

void j1Map::CreateColliders()
{

	// Background standalone colliders
	int background[158] = {
		12, 424,
		105, 494,
		103, 531,
		219, 531,
		222, 497,
		318, 423,
		318, 312,
		278, 277,
		317, 262,
		317, 254,
		313, 251,
		317, 246,
		305, 171,
		320, 86,
		319, 76,
		314, 68,
		307, 59,
		297, 52,
		285, 49,
		268, 48,
		251, 52,
		239, 61,
		232, 75,
		228, 96,
		220, 96,
		220, 42,
		288, 41,
		295, 42,
		302, 44,
		309, 47,
		319, 55,
		324, 64,
		328, 74,
		329, 81,
		329, 494,
		348, 494,
		348, 67,
		344, 55,
		338, 42,
		325, 32,
		315, 26,
		303, 25,
		50, 25,
		42, 28,
		33, 31,
		25, 37,
		19, 47,
		14, 56,
		11, 64,
		10, 74,
		10, 87,
		12, 97,
		28, 136,
		50, 187,
		61, 214,
		62, 219,
		64, 226,
		65, 233,
		65, 240,
		62, 249,
		57, 257,
		52, 262,
		42, 238,
		39, 221,
		39, 192,
		41, 168,
		14, 154,
		16, 173,
		12, 216,
		14, 235,
		19, 259,
		31, 289,
		12, 311,
		12, 354,
		12, 370,
		12, 381,
		12, 393,
		12, 405,
		12, 416
	};
	PhysBody* colliderb1 = App->physics->CreateChain(0, 0, background, 158, 0x0001, 0x0002);
	colliderb1->body->SetType(b2_staticBody);
		int big_kicker_left_points[24] = {
		77, 0,
		9, 8,
		5, 11,
		2, 15,
		2, 20,
		3, 25,
		5, 28,
		76, 38,
		86, 34,
		92, 23,
		91, 12,
		84, 3
	};
	//big_left_kicker_coll = App->physics->CreateRevoluteJointPoly(15, big_kicker_left_points, 24, 225, 1107, 70, 20, 200, 150, 250, -90, 0x0003, 0x0001);
	int background2[12] = {
		36, 371,
		44, 371,
		46, 407,
		110, 450,
		103, 460,
		36, 411
	};
	PhysBody* colliderb2 = App->physics->CreateChain(0, 0, background2, 12, 0x0001, 0x0002);
	colliderb2->body->SetType(b2_staticBody);

	int background3[16] = {
		221, 452,
		228, 461,
		293, 413,
		293, 376,
		290, 372,
		287, 375,
		286, 408,
		226, 448
	};
	PhysBody* colliderb3 = App->physics->CreateChain(0, 0, background3, 16, 0x0001, 0x0002);
	colliderb3->body->SetType(b2_staticBody);

	int background4[30] = {
		50, 118,
		111, 93,
		111, 46,
		107, 41,
		65, 42,
		55, 45,
		47, 49,
		40, 54,
		35, 60,
		31, 70,
		31, 78,
		32, 90,
		34, 95,
		39, 105,
		44, 112
	};

	PhysBody* colliderb4 = App->physics->CreateChain(0, 0, background4, 30, 0x0001, 0x0002);
	colliderb4->body->SetType(b2_staticBody);

	int background5[20] = {
		131, 96,
		131, 62,
		133, 59,
		136, 58,
		139, 59,
		141, 62,
		141, 96,
		139, 99,
		135, 100,
		133, 99
	};
	PhysBody* colliderb5 = App->physics->CreateChain(0, 0, background5, 20, 0x0001, 0x0002);
	colliderb5->body->SetType(b2_staticBody);

	int background6[20] = {
		161, 96,
		161, 62,
		163, 59,
		166, 58,
		169, 59,
		171, 62,
		171, 96,
		169, 99,
		165, 100,
		163, 99
	};
	PhysBody* colliderb6 = App->physics->CreateChain(0, 0, background6, 20, 0x0001, 0x0002);
	colliderb6->body->SetType(b2_staticBody);

	int background7[20] = {
		191, 96,
		191, 62,
		193, 59,
		196, 58,
		199, 59,
		201, 62,
		201, 96,
		199, 99,
		195, 100,
		193, 99
	};
	PhysBody* colliderb7 = App->physics->CreateChain(0, 0, background7, 20, 0x0001, 0x0002);
	colliderb7->body->SetType(b2_staticBody);

	bouncing_circle1->pb = App->physics->CreateCircle(116, 153, 20, b2_staticBody, 0x0001, 0x0002);
	bouncing_circle2->pb = App->physics->CreateCircle(168, 190, 20, b2_staticBody, 0x0001, 0x0002);
	bouncing_circle3->pb = App->physics->CreateCircle(219, 143, 20, b2_staticBody, 0x0001, 0x0002);
	//330,52 Default position
	ball->pb = App->physics->CreateCircle(330, 52, 7,b2_dynamicBody, 0x0002, 0x0001);

}

void j1Map::Draw()
{
	Blit(bg1->texture, bg1->pos.x, bg1->pos.y, &bg1->rect);
	Blit(ball->texture, METERS_TO_PIXELS(ball->pb->body->GetPosition().x-8), METERS_TO_PIXELS(ball->pb->body->GetPosition().y-8), &ball->rect);
}

// Called before quitting
bool j1Map::CleanUp()
{
	LOG("Unloading map");

	return true;
}

void j1Map::Blit(SDL_Texture * texture, int x, int y, const SDL_Rect* section)
{
	App->render->Blit(texture, x, y, section);
}




