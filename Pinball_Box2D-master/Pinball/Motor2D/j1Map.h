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

public:
	Sprite*		 bg1;
	Sprite*      ball;
	Sprite*		 bouncing_circle1;
	Sprite*		 bouncing_circle2;
	Sprite*		 bouncing_circle3;
	Sprite*		 kickerLeft;
	Sprite*		 kickerRight;
	Sprite*		 bouncersbgOn;
	Sprite*		 bouncersbgOff;
	Sprite*		 bouncerLeft;
	Sprite*		 bouncerRight;
	Sprite*		 bouncerMid;
	Sprite*		 bouncerHitLeft;
	Sprite*		 bouncerHitRight;
	Sprite*		 bouncerHitMid;

	b2RevoluteJoint*		 big_left_kicker_coll;

};

#endif // __j1MAP_H__