{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Login where

import Import
import Text.Lucius
import Text.Julius
--import Network.HTTP.Types.Status
import Database.Persist.Postgresql

-- renderDivs
formLogin :: Form (Text, Text)
formLogin = renderBootstrap $ (,)
    <$> areq emailField "E-mail: " Nothing
    <*> areq passwordField "Senha: " Nothing

getEntrarR :: Handler Html
getEntrarR = do 
    (widget,_) <- generateFormPost formLogin
    msg <- getMessage
    defaultLayout $ 
        [whamlet|
            $maybe mensa <- msg 
                <div>
                    ^{mensa}
            
            <h1>
                ENTRAR
            
            <form method=post action=@{EntrarR}>
                ^{widget}
                <input type="submit" value="Entrar">
        |]

postEntrarR :: Handler Html
postEntrarR = do 
    ((result,_),_) <- runFormPost formLogin
    case result of 
        FormSuccess ("gouveiaramos.me@gmail.com","worldstars21") -> do 
            setSession "_NOME" "admin"
            redirect AdminR
        FormSuccess (email,senha) -> do 
           -- select * from usuario where email=digitado.email
           usuario <- runDB $ getBy (UniqueEmailIx email)
           case usuario of 
                Nothing -> do 
                    setMessage [shamlet|
                        <div>
                            E-mail N ENCONTRADO!
                    |]
                    redirect EntrarR
                Just (Entity _ usu) -> do 
                    if (usuarioSenha usu == senha) then do
                        setSession "_NOME" (usuarioNome usu)
                        redirect HomeR
                    else do 
                        setMessage [shamlet|
                            <div>
                                Senha INCORRETA!
                        |]
                        redirect EntrarR 
        _ -> redirect HomeR

postSairR :: Handler Html 
postSairR = do 
    deleteSession "_NOME"
    redirect HomeR
    
getSairR :: Handler Html 
getSairR = do 
    deleteSession "_NOME"
    redirect HomeR    

getAdminR :: Handler Html
getAdminR = do 
    defaultLayout [whamlet|
        <h1>
            BEM-VINDO MY KING!
            
            
        <ul>
           <li>
              <a href=@{CoachR}>
                        CADASTRO DE COACH
           <li> 
              <a href=@{PalestraR}>
                        CADASTRO DE PALESTRA
           <li>
              <a href=@{TemaR}>
                        DEFINICAO DE TEMAS
           <li>
              <a href=@{AdminR}>
                        ADMINISTRADOR
           <li>
              <a href=@{UsuarioR}>
                        USUARIO
           <li>
              <a href=@{MostraCoachR}>
                        EXIBIR COACHS CADASTRADOS
           <li>
              <a href=@{MostraTemaR}>
                        EXIBIR TEMAS CADASTRADOS
            <li>
              <a href=@{SairR}>
                        FINALIZAR SESSAO
        

    |]
    
    