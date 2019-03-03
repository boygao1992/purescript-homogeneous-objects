module Data.HObject.Record where

import Control.Monad.Except (runExcept)
import Data.Argonaut.Core (Json)
import Data.Either (Either(..), either)
import Data.HObject (HObject)
import Effect.Exception (Error, error)
import Foreign (unsafeToForeign)
import Foreign.Class (class Decode, decode)
import Prelude (($), show)


-- | Converts a Json to a Record
jsonToRecord :: forall a. Decode a => Json -> Either Error a
jsonToRecord json = either (\err -> Left (error $ show err)) Right $ runExcept (decode (unsafeToForeign json))


-- | Converts an HObject to a Record
hObjToRecord :: forall a b. Decode b => HObject a -> Either Error b
hObjToRecord hobj = either (\err -> Left (error $ show err)) Right $ runExcept (decode (unsafeToForeign hobj))


-- | Gets the contructor name for the type
foreign import structName :: forall a . a -> String
