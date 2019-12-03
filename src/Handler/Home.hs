{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Home where

import Import
import Data.FileEmbed (embedFile)
import Text.Lucius
import Text.Julius
--import Network.HTTP.Types.Status
import Database.Persist.Postgresql

getAdsR :: Handler TypedContent
getAdsR = return $ TypedContent "text/plain"
    $ toContent $(embedFile "static/ads.txt")


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
        [whamlet|
        
                     
        <div id="48248-6">
        <script src="//ads.themoneytizer.com/s/gen.js?type=6">
        <script src="//ads.themoneytizer.com/s/requestform.js?siteId=48248&formatId=6">
        
        <ul>
           <li>
              <a href=@{CoachR}>
                        COACH
           <li> 
              <a href=@{PalestraR}>
                        PALESTRA
           <li>
              <a href=@{TemaR}>
                        TEMA
           <li>
              <a href=@{AdminR}>
                        ADMINISTRADOR
           <li>
              <a href=@{UsuarioR}>
                        USUARIO
                        
    
        
        
        <body>
        <div style="text-align:center;" id="48248-31">
        <script src="//ads.themoneytizer.com/s/gen.js?type=31">
        <script src="//ads.themoneytizer.com/s/requestform.js?siteId=48248&formatId=31">
        
        <footer>
        <div id="48248-2">
        <script src="//ads.themoneytizer.com/s/gen.js?type=2">
        <script src="//ads.themoneytizer.com/s/requestform.js?siteId=48248&formatId=2">
        
        
        
        |]    