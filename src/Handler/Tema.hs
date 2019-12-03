{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Tema where

import Import
import Text.Lucius
import Text.Julius
--import Network.HTTP.Types.Status
import Database.Persist.Postgresql

-- renderDivs
formTema :: Form Tema 
formTema = renderBootstrap $ Tema
    <$> areq textField "Nome: " Nothing
    <*> areq dayField  "Dia: " Nothing
    <*> areq textField "Descrição: " Nothing

getTemaR :: Handler Html
getTemaR = do 
    (widget,_) <- generateFormPost formTema
    msg <- getMessage
    defaultLayout $ 
        [whamlet|
            $maybe mensa <- msg 
                <div>
                    ^{mensa}
            
            <h1>
                CADASTRO DE TEMA DA PALESTRA
            
            <form method=post action=@{TemaR}>
                ^{widget}
                <input type="submit" value="Cadastrar">
        |]

postTemaR :: Handler Html
postTemaR = do 
    ((result,_),_) <- runFormPost formTema
    case result of 
        FormSuccess tema -> do 
            runDB $ insert tema 
            setMessage [shamlet|
                <div>
                    TEMA DA PALESTRA INCLUIDO COM SUCESSO
            |]
            redirect TemaR
        _ -> redirect HomeR
