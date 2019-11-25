{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Home where

import Import
--import Network.HTTP.Types.Status
import Database.Persist.Postgresql

getHomeR :: Handler Html
getHomeR = do 
    sess <- lookupSession "_NOME"
    defaultLayout $ do 
        -- addScriptRemote "url" -> CHAMA JS EXTERNO
        -- addScript (StaticR script_js), ONDE script 
        -- eh o nome do seu script.
        -- pasta css, arquivo: bootstrap.css
        addStylesheet (StaticR css_bootstrap_css)
        
        toWidgetHead [julius|
            function ola(){
                alert("ola");
            }
        |]
           