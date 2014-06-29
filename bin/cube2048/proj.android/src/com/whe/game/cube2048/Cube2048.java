/****************************************************************************
Copyright (c) 2010-2012 cocos2d-x.org

http://www.cocos2d-x.org

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
****************************************************************************/
package com.whe.game.cube2048;

import org.cocos2dx.lib.Cocos2dxActivity;

import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.AdSize;
import com.google.android.gms.ads.AdView;


import android.content.Context;
import android.os.Bundle;

import android.view.Gravity;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.RelativeLayout.LayoutParams;



public class Cube2048 extends Cocos2dxActivity {
	
	private AdView adView =null;
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		STATIC_REF = this;
		setupAds();
	}

    static {
    	System.loadLibrary("game");
    }
    
    public static Context getContext(){
        return STATIC_REF;
    }
    
    public static Context STATIC_REF = null;
    
    private void setupAds()  
    {  
    	adView = new AdView(this);
    	adView.setAdUnitId("ca-app-pub-9720017543368967/7093125935");
    	adView.setAdSize(AdSize.BANNER);
    	LinearLayout layout = new LinearLayout(this);  
        layout.setOrientation(LinearLayout.HORIZONTAL);  
        LayoutParams lp = new LayoutParams(LayoutParams.MATCH_PARENT,LayoutParams.WRAP_CONTENT);
        //lp.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM);
        //layout.setGravity(Gravity.BOTTOM);
        addContentView(layout, lp); 
        
        RelativeLayout rl = new RelativeLayout(this);
        LayoutParams adlp = new LayoutParams(LayoutParams.MATCH_PARENT,LayoutParams.WRAP_CONTENT);
        adlp.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM);
        rl.addView(adView,adlp);
        layout.addView(rl);
        adView.loadAd(new AdRequest.Builder().build());  
    }
    
    @Override
    public void onPause() {
      adView.pause();
      super.onPause();
    }

    @Override
    public void onResume() {
      super.onResume();
      adView.resume();
    }

    @Override
    public void onDestroy() {
      adView.destroy();
      super.onDestroy();
    }

}
