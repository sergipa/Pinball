#ifndef __j1MAP_H__
#define __j1MAP_H__

#include "PugiXml/src/pugixml.hpp"
#include "p2List.h"
#include "p2Point.h"
#include "j1Module.h"


class j1Map : public j1Module
{
public:

	class Sprite
	{
	public:
		Sprite()
		{
		}

		Sprite(SDL_Texture* _texture, int _x, int _y, int _w, int _h, int _posx, int _posy)
		{
			texture = _texture;
			rect.x = _x; rect.y = _y; rect.w = _w; rect.h = _h;
			pos.x = _posx;
			pos.y = _posy;
		}

		Sprite(SDL_Texture* _texture, int _x, int _y, int _w, int _h)
		{
			texture = _texture;
			rect.x = _x; rect.y = _y; rect.w = _w; rect.h = _h;
		}

		Sprite(SDL_Texture* _texture, SDL_Rect _rect, int _posx, int _posy)
		{
			texture = _texture;
			rect = _rect;
			pos.x = _posx;
			pos.y = _posy;
		}

		~Sprite()
		{}

		SDL_Texture* texture;
		SDL_Rect rect;
		iPoint pos;
		PhysBody* pb = nullptr;
		SDL_Texture* originalTexture;

	private:
	};

	j1Map();

	// Destructor
	virtual ~j1Map();

	// Called before render is available
	bool Awake(pugi::xml_node& conf);

	bool Start();

	bool PostUpdate();
	// Called each loop iteration
	void CreateColliders();
	void Draw();

	// Called before quitting
	bool CleanUp();

	void Blit(SDL_Texture* texture, int x, int y, const SDL_Rect* section);

	void OnCollision(PhysBody* bodyA, PhysBody* bodyB);

	void ResetImages(Sprite* bodyA);

	void ResetGame();

public:
	Sprite*		 bgAbove;
	Sprite*		 bgBelow;
	Sprite*      ball;
	Sprite*		 launcher;
	Sprite*		 bouncing_circle1;
	Sprite*		 bouncing_circle2;
	Sprite*		 bouncing_circle3;
	Sprite*		 kickerLeft;
	Sprite*		 kickerRight;
	Sprite*		 kickerTopRight;
	Sprite*		 bouncersbgOn;
	Sprite*		 bouncersbgOff;
	Sprite*		 bouncerLeft;
	Sprite*		 bouncerRight;
	Sprite*		 bouncerMid;
	Sprite*		 cercleBelowMidGirl;
	Sprite*		 midGirl;
	Sprite*		 midBoys;
	Sprite*		 multiBallIndicator;
	Sprite*		 superFreakIndicator;
	Sprite*		 bouncerBottomLeft;
	Sprite*		 bouncerBottomRight;
	Sprite*		 bottomHalfCercleLeft;
	Sprite*		 bottomHalfCercleRight;
	Sprite*		 superFreakActivator1;
	Sprite*		 superFreakActivator2;
	Sprite*		 superFreakActivator3;
	Sprite*		 superFreakActivator4;
	Sprite*		 superFreakActivator5;
	Sprite*		 oldFace;
	Sprite*		 mid1xBlue;
	Sprite*		 mid2x;
	Sprite*		 mid4x;
	Sprite*		 big5xOff;
	Sprite*		 rail;
	Sprite*		 bouncerBottomLeftStick;
	Sprite*		 bouncerBottomRightStick;
	Sprite*		 rightBlueActivator1;
	Sprite*		 rightBlueActivator2;
	Sprite*		 rightBlueActivator3;
	Sprite*		 superFreakYellow_S;
	Sprite*		 superFreakYellow_U;
	Sprite*		 superFreakYellow_P;
	Sprite*		 superFreakYellow_E;
	Sprite*		 superFreakYellow_R;
	Sprite*		 superFreakYellow_F;
	Sprite*		 superFreakYellow_R2;
	Sprite*		 superFreakYellow_E2;
	Sprite*		 superFreakYellow_A;
	Sprite*		 superFreakYellow_K;
	Sprite*		 superFreakYellow_S2;
	Sprite*		 superFreakYellow_U2;
	Sprite*		 superFreakYellow_P2;
	Sprite*		 superFreakYellow_E3;
	Sprite*		 superFreakYellow_R3;
	Sprite*		 x2IndicatorOff;
	Sprite*		 x3IndicatorOff;
	Sprite*		 x4IndicatorOff;
	Sprite*		 x2Indicator2Off;
	Sprite*		 x3Indicator2Off;
	Sprite*		 x4Indicator2Off;
	Sprite*		 x2Indicator3Off;
	Sprite*		 x3Indicator3Off;
	Sprite*		 x4Indicator3Off;
	Sprite*		 x2IndicatorOn;
	Sprite*		 x3IndicatorOn;
	Sprite*		 x4IndicatorOn;
	Sprite*		 rightArrow;
	Sprite*		 doubleArrow;
	Sprite*		 points200Off1;
	Sprite*		 points200Off2;
	Sprite*		 points200Off3;
	Sprite*		 points200Off4;

	Sprite*		 resetImage = nullptr;

	b2RevoluteJoint*		 left_kicker_coll;
	b2RevoluteJoint*		 right_low_kicker_coll;
	b2RevoluteJoint*		 right_top_kicker_coll;

	b2PrismaticJoint* spring;

	PhysBody* endBall;
	PhysBody* bouncerLeftCheck;
	PhysBody* bouncerRightCheck;
	PhysBody* bouncerMidCheck;
	PhysBody* superFreakActivator1Check;
	PhysBody* superFreakActivator2Check;
	PhysBody* superFreakActivator3Check;
	PhysBody* superFreakActivator4Check;
	PhysBody* superFreakActivator5Check;
	PhysBody* triangle_left_coll;
	PhysBody* triangle_right_coll;

	PhysBody* bodA;
	PhysBody* bodB;

	uint resetImagesTimer;
	uint remainingBalls;
	uint score;

	p2List<Sprite*> resetImagesList;

	uint bouncerSound;
	uint kickerSound;
	uint chargeBallSound;
	uint launchBallSound;
	uint letterSound;
	uint bottomBouncerSound;

	bool avoidDuplicated;
	uint avoidDuplicatedTimer;

};

#endif // __j1MAP_H__