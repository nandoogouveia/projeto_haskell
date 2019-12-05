{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Coach where

import Import
import Text.Lucius
import Text.Julius
--import Network.HTTP.Types.Stactus
import Database.Persist.Postgresql

-- renderDivs
formCoach :: Form Coach 
formCoach = renderBootstrap $ Coach
    <$> areq textField "Nome: " Nothing
    <*> areq dayField "Nasc: " Nothing

getCoachR :: Handler Html
getCoachR = do 
    (widget,_) <- generateFormPost formCoach
    msg <- getMessage
    defaultLayout $ do
        addStylesheet (StaticR css_bootstrap_css)
        addStylesheet (StaticR css_style_css)
        [whamlet|
            $maybe mensa <- msg 
                <div>
                    ^{mensa}
            
            <h1>
                CADASTRO DE COACH
            
            <form method=post action=@{CoachR}>
                ^{widget}
                <input type="submit" value="Cadastrar">
        |]

postCoachR :: Handler Html
postCoachR = do 
    ((result,_),_) <- runFormPost formCoach
    case result of 
        FormSuccess coach -> do 
            runDB $ insert coach 
            setMessage [shamlet|
                <div>
                    COACH INCLUIDO COM SUCESSO
            |]
            redirect CoachR
        _ -> redirect HomeR

getMostraCoachR :: Handler Html 
getMostraCoachR = do 
    -- select * from coach order by coach.nome
    coachs <- runDB $ selectList [] [Asc CoachNome]
    defaultLayout $ do
        addStylesheet (StaticR css_bootstrap_css)
        addStylesheet (StaticR css_style_css) 
        $(whamletFile "templates/coachs.hamlet")

postApagarCoachR :: CoachId -> Handler Html 
postApagarCoachR aid = do 
    _ <- runDB $ get404 aid
    runDB $ delete aid 
    redirect MostraCoachR