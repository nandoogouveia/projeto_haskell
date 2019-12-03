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
        
        |]
         [whamlet|  
            <ul>
                <li>
                    <a href=@{CoachR}>
                        COACH
                
                <li>
                    <a href=@{TemaR}>
                        TEMA
                
                <li>
                    <a href=@{PalestraR}>
                        PALESTRA
                
                $maybe nome <- sess
                    <li>
                        Ola #{nome}
                    <form method=post action=@{SairR}>
                        <input type="submit" value="Sair">
                $nothing
                    <li>
                        Convidado!
            
            <button class="btn btn-danger" onclick="ola()">
                OLA
        |]
