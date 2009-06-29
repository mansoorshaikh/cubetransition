/*
 *  Constants.h
 *  GameEffects
 *
 *  Created by Anto on 5/13/09.
 *  Copyright 2009 JPAStudio,Inc. All rights reserved.
 *
 */

#ifdef HAS_STUATS_BAR
#define PAGE_VERTICAL_WIDTH                      320.0f
#define PAGE_VERTICAL_HEIGHT                     460.0f
#define PAGE_HORIZONTAL_WIDTH                    480.0f
#define PAGE_HORIZONTAL_HEIGHT                   300.0f
#define CONTENT_Y_OFFSET                         20.0f
#else
#define PAGE_VERTICAL_WIDTH                      320.0f
#define PAGE_VERTICAL_HEIGHT                     480.0f
#define PAGE_HORIZONTAL_WIDTH                    480.0f
#define PAGE_HORIZONTAL_HEIGHT                   320.0f
#define CONTENT_Y_OFFSET                         0.0f
#endif
#define LOADING_WIDTH                            30.0f
#ifdef DEBUG
#define debugLog(...) NSLog(__VA_ARGS__)
#else
#define debugLog(...)          // Nothing
#endif

