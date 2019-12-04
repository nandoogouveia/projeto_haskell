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
    defaultLayout $ 
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
        
mostrarCoachR :: Handler Value
    coaches <- runDB $ selectList [] [Asc CoachNome]
    coachesComInnerJoin <- mapM (\(Entity _ (Coach did _ _ _ _ _ _ _ genid clid )) coaches
    defaultLayout $ do
		[whamlet|
			<table>
				<thead>
					<th>Nome
					<th>Nascimento
				<tbody>		
					$forall coach <- coaches
						<td>#{coachNome.entityVal}
						<td>#{coachDia.entityVal}
		|]        