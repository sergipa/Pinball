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
	
	// Background
	bg1 = new Sprite(App->tex->Load("images/Background.png"), 0, 0, 395, 537, 0, 0);
	//Ball
	ball = new Sprite(App->tex->Load("images/Ball.png"), 0, 0, 16, 16);

	//Bouncing Circles
	bouncing_circle1 = new Sprite(App->tex->Load("images/Ball.png"), 0, 0, 62, 62);
	bouncing_circle2 = new Sprite(App->tex->Load("images/Ball.png"), 0, 0, 62, 62);
	bouncing_circle3 = new Sprite(App->tex->Load("images/Ball.png"), 0, 0, 62, 62);

	//Kickers
	kickerLeft = new Sprite(App->tex->Load("images/kickerLeft.png"), 0, 0, 50, 31, 112, 485);
	kickerRight = new Sprite(App->tex->Load("images/kickerRight.png"), 0, 0, 50, 31, 193, 485);

	//Bouncers
	bouncerLeft = new Sprite(App->tex->Load("images/bouncerIdle.png"), 0, 0, 39, 40, 102, 138);
	bouncerRight = new Sprite(App->tex->Load("images/bouncerIdle.png"), 0, 0, 39, 40, 212, 129);
	bouncerMid = new Sprite(App->tex->Load("images/bouncerIdle.png"), 0, 0, 39, 40, 157, 177);
	bouncersbgOn = new Sprite(App->tex->Load("images/3MidCerclesOn.png"), 0, 0, 179, 117, 86, 114);
	bouncersbgOff = new Sprite(App->tex->Load("images/3MidCerclesOff.png"), 0, 0, 179, 117, 86, 114);
	bouncerHitLeft = new Sprite(App->tex->Load("images/bouncerHit.png"), 0, 0, 39, 39, 0, 0);
	bouncerHitRight = new Sprite(App->tex->Load("images/bouncerHit.png"), 0, 0, 39, 39, 0, 0);
	bouncerHitMid = new Sprite(App->tex->Load("images/bouncerHit.png"), 0, 0, 39, 39, 0, 0);

	return ret;
}

void j1Map::CreateColliders()
{

	// Background standalone colliders
	int background[112] = {
		355, 527,
		374, 527,
		374, 68,
		366, 50,
		354, 36,
		337, 27,
		324, 24,
		52, 24,
		35, 31,
		20, 45,
		11, 64,
		9, 81,
		12, 101,
		19, 120,
		25, 135,
		37, 161,
		50, 190,
		58, 209,
		66, 229,
		69, 244,
		67, 257,
		61, 269,
		55, 278,
		44, 294,
		33, 310,
		22, 320,
		10, 333,
		10, 451,
		116, 532,
		116, 600,
		237, 600,
		240, 530,
		341, 452,
		341, 333,
		297, 296,
		339, 278,
		329, 184,
		341, 97,
		339, 80,
		331, 66,
		319, 55,
		301, 50,
		273, 52,
		259, 60,
		248, 77,
		246, 89,
		243, 100,
		235, 100,
		235, 47,
		237, 42,
		308, 42,
		319, 45,
		332, 50,
		342, 56,
		350, 68,
		355, 80
	};
	PhysBody* colliderb1 = App->physics->CreateChain(0, 0, background, 112, 0x0001, 0x0002);
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
		221, 452+20,
		228, 461+20,
		293, 413+20,
		293, 376+20,
		290, 372+20,
		287, 375+20,
		286, 408+20,
		226, 448+20
	};
	PhysBody* colliderb3 = App->physics->CreateChain(0, 0, background3, 16, 0x0001, 0x0002);
	colliderb3->body->SetType(b2_staticBody);

	int background4[30] = {
		50, 122,
		111, 97,
		111, 50,
		107, 45,
		65, 46,
		55, 49,
		47, 53,
		40, 58,
		35, 64,
		31, 74,
		31, 82,
		32, 94,
		34, 99,
		39, 109,
		44, 116
	};

	PhysBody* colliderb4 = App->physics->CreateChain(0, 0, background4, 30, 0x0001, 0x0002);
	colliderb4->body->SetType(b2_staticBody);

	int background5[20] = {
		140, 96+3,
		140, 62+3,
		142, 59+3,
		145, 58+3,
		148, 59+3,
		150, 62+3,
		150, 96+3,
		148, 99+3,
		144, 100+3,
		142, 99+3
	};
	PhysBody* colliderb5 = App->physics->CreateChain(0, 0, background5, 20, 0x0001, 0x0002);
	colliderb5->body->SetType(b2_staticBody);

	int background6[20] = {
		161+10, 96+3,
		161+10, 62+3,
		163+10, 59+3,
		166+10, 58+3,
		169+10, 59+3,
		171+10, 62+3,
		171+10, 96+3,
		169+10, 99+3,
		165+10, 100+3,
		163+10, 99+3
	};
	PhysBody* colliderb6 = App->physics->CreateChain(0, 0, background6, 20, 0x0001, 0x0002);
	colliderb6->body->SetType(b2_staticBody);

	int background7[20] = {
		191+12, 96+3,
		191+12, 62+3,
		193+12, 59+3,
		196+12, 58+3,
		199+12, 59+3,
		201+12, 62+3,
		201+12, 96+3,
		199+12, 99+3,
		195+12, 100+3,
		193+12, 99+3
	};
	PhysBody* colliderb7 = App->physics->CreateChain(0, 0, background7, 20, 0x0001, 0x0002);
	colliderb7->body->SetType(b2_staticBody);


	int testKicker[6] = {
		12,-10,
		30,-5,
		12,5,
	};

	bouncing_circle1->pb = App->physics->CreateCircle(116+7, 153+6, 20, b2_staticBody, 0x0001, 0x0002);
	bouncing_circle2->pb = App->physics->CreateCircle(168+7, 190+6, 20, b2_staticBody, 0x0001, 0x0002);
	bouncing_circle3->pb = App->physics->CreateCircle(219+15,143+6, 20, b2_staticBody, 0x0001, 0x0002);
	//360,52 Default position
	ball->pb = App->physics->CreateCircle(365, 352, 7,b2_dynamicBody, 0x0002, 0x0001);

	left_kicker_coll = App->physics->CreateRevoluteJointPoly(10, testKicker, 6, 112, 485, 10, 10, 40, 320, 250, 0, 0x0003, 0x0002);

}

void j1Map::Draw()
{
	Blit(bg1->texture, bg1->pos.x, bg1->pos.y, &bg1->rect);
	Blit(ball->texture, METERS_TO_PIXELS(ball->pb->body->GetPosition().x-8), METERS_TO_PIXELS(ball->pb->body->GetPosition().y-8), &ball->rect);
	Blit(kickerLeft->texture, kickerLeft->pos.x, kickerLeft->pos.y, &kickerLeft->rect);
	Blit(kickerRight->texture, kickerRight->pos.x, kickerRight->pos.y, &kickerRight->rect);
	Blit(bouncersbgOn->texture, bouncersbgOn->pos.x, bouncersbgOn->pos.y, &bouncersbgOn->rect);
	Blit(bouncerLeft->texture, bouncerLeft->pos.x, bouncerLeft->pos.y, &bouncerLeft->rect);
	Blit(bouncerRight->texture, bouncerRight->pos.x, bouncerRight->pos.y, &bouncerRight->rect);
	Blit(bouncerMid->texture, bouncerMid->pos.x, bouncerMid->pos.y, &bouncerMid->rect);
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




