{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Palestra where

import Import
import Text.Lucius
import Text.Julius
--import Network.HTTP.Types.Status
import Database.Persist.Postgresql

temaCB = do
  rows <- runDB $ selectList [] [Asc TemaNome]
  optionsPairs $ 
      map (\r -> (temaNome $ entityVal r, entityKey r)) rows

coachCB = do
  rows <- runDB $ selectList [] [Asc CoachNome]
  optionsPairs $ 
      map (\r -> (coachNome $ entityVal r, entityKey r)) rows

-- renderDivs
formPalestra :: Form Palestra 
formPalestra = renderBootstrap $ Palestra
    <$> areq (selectField temaCB) "Tema: " Nothing
    <*> areq (selectField coachCB) "Coach: " Nothing
    <*> areq intField "Dia da Palestra: " Nothing

getPalestraR :: Handler Html
getPalestraR = do 
    (widget,_) <- generateFormPost formPalestra
    msg <- getMessage
    defaultLayout $ do
        addStylesheet (StaticR css_bootstrap_css)
        addStylesheet (StaticR css_style_css)
        [whamlet|
            $maybe mensa <- msg 
                <div>
                    ^{mensa}
            
            <h1>
                CADASTRO DE PALESTRAS
            
            <form method=post action=@{PalestraR}>
                ^{widget}
                <input type="submit" value="Cadastrar">
        |]

postPalestraR :: Handler Html
postPalestraR = do 
    ((result,_),_) <- runFormPost formPalestra
    case result of 
        FormSuccess palestra -> do 
            runDB $ insert palestra 
            setMessage [shamlet|
                <div>
                    PALESTRA INCLUIDA
            |]
            redirect PalestraR
        _ -> redirect HomeR

getElencoR :: TemaId -> Handler Html
getElencoR temaid = do 
    let sql = "SELECT ??,??,?? FROM tema \
          \ INNER JOIN palestra ON palestra.temaid = tema.id \
          \ INNER JOIN coach ON palestra.coachid = coach.id \
          \ WHERE tema.id = ?"
    tema <- runDB $ get404 temaid
    coachs <- runDB $ rawSql sql [toPersistValue temaid] :: Handler [(Entity Tema,Entity Palestra,Entity Coach)]
    defaultLayout $ do
        addStylesheet (StaticR css_bootstrap_css)
        addStylesheet (StaticR css_style_css)
        [whamlet|
            <h1>
                PALESTRA SOBRE #{temaNome tema}
            <ul>
                $forall (Entity _ _, Entity _ _, Entity _ coach) <- coachs
                    <li>
                        #{coachNome coach}
        |]		