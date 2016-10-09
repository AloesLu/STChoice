require('MHNewPostDetailViewController');
require('UMSocialData,UMSocialConfig,UMSocialDataService,MHPost,MH_NetAPIManager,MHUserManager,UITapImageView,UIImageView,UIImage');
defineClass('MHNewPostDetailViewController', {
            init: function() {
            self = self.super().init();
            self.setValue_forKey(["JSPatch"], "_shareImageView");
                return self;
            },
            shareToPlatform: function(platform) {
            var shareImageView = self.valueForKey("_shareImageView");
            var weakself=self;
            UMSocialData.defaultData().extConfig().setTitle(self.nowPost().absContent());
            UMSocialConfig.setFinishToastIsHidden_position(YES, 1000003);
            UMSocialDataService.defaultDataService().postSNSWithTypes_content_image_location_urlResource_presentedController_completion([platform], self.nowPost().absContent(), shareImageView.image() != null ? shareImageView.image() : UIImage.imageNamed("kDefaultImage80"), null, null, weakself, block('UMSocialResponseEntity*', function(response) {
                                                                                                                                                        if (response.responseCode() == 200) {                                                                                                                                                                                     weakself.dismissShareView();
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   MH_NetAPIManager.sharedManager().request__shareAddAccount__WithUserId_token_andBlock(MHUserManager.sharedManager().getkUserDefaults__userId(), MHUserManager.sharedManager().getkUserDefaults__userToken(), block('id,NSError*', function(data, error) {
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   }));
                                                                                                                                                                                                                                                                       }                                                                                                                                                                                     }));
            
            },
            });